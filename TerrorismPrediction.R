library(twitteR)
consumer_key <- "eu5GLPk09I14mfeGFSiPnV0nH"
consumer_key_secret <- "GuaxHNWMuZ6k7xCtcEs5vuYXVMQpBJ3R03fyLe0dcRICmCeA8N"
access_token <- "2983155133-TpUsnGYUz8UvPurDxXEHLma0NQdFV143uDKyNjC"
access_token_secret <- "bIoXdrTujb4DJgMJwUTmz9r3scwW8ZN627pnOHFPXfzz5"
setup_twitter_oauth(consumer_key, consumer_key_secret, access_token, access_token_secret)

#No of Tweets extracted
numOfTweets = 1000

#collecting data
library(NLP)
library(tm)
library(SnowballC)
library(wordcloud)
washington <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='38.9047,-77.0164,100mi'))
ny <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='40.7127,-74.0059,100mi'))
london <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='51.5072,-0.1275,100mi'))
san <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='37.7833,-122.4167,100mi'))
los <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='34.0500,-118.2500,100mi'))
chicago <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='41.8369,-87.6847,100mi'))
boston <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='42.3601,-71.0589,100mi'))


data <- list()
data[["Washington"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='38.9047,-77.0164,100mi'))
data[["Newyork"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='40.7127,-74.0059,100mi'))
data[["London"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='51.5072,-0.1275,100mi'))
data[["SanFrancisco"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='37.7833,-122.4167,100mi'))
data[["LosAngeles"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='34.0500,-118.2500,100mi'))
data[["Chicago"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='41.8369,-87.6847,100mi'))
data[["Boston"]] <- twListToDF(searchTwitter("ISIS",n=numOfTweets, geocode='42.3601,-71.0589,100mi'))

for(i in 1:length(data)){
  temp <- as.data.frame(data[[i]])
  write.csv(temp,paste0("E:/git/TerrorismPrediction/API_Data/",names(data)[i],".csv"))
}

twitter1 <- boston
df <- do.call("rbind", lapply(twitter1, as.data.frame))

removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
df[,1] <- removeURL(df[,1])
removeref <- function(x) gsub("href*", "", x)
df[,1] <- removeref(df[,1])

myCorpus <- Corpus(VectorSource(df[,1])) # corpus forming

myCorpus <- tm_map(myCorpus,removePunctuation)
myCorpus <- tm_map(myCorpus,stripWhitespace)
myTdm <- TermDocumentMatrix(myCorpus, control=list(minWordLength=1))
m <- as.matrix(myTdm)
wordFreq <- sort(rowSums(m), decreasing=TRUE)
set.seed(375)
grayLevels <- gray( (wordFreq+10) / (max(wordFreq)+10) )
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=1, random.order=F, colors=rainbow(4),title="Tweet words for US")

# required pakacges
library(twitteR)
library(sentiment)
library(plyr)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)

for(i in 1:length(data)){
temp <- as.data.frame(data[[i]])
  
some_txt = temp$text

# remove retweet entities
some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
# remove at people
some_txt = gsub("@\\w+", "", some_txt)
# remove punctuation
some_txt = gsub("[[:punct:]]", "", some_txt)
# remove numbers
some_txt = gsub("[[:digit:]]", "", some_txt)
# remove html links
some_txt = gsub("http\\w+", "", some_txt)
# remove unnecessary spaces
some_txt = gsub("[ \t]{2,}", "", some_txt)
some_txt = gsub("^\\s+|\\s+$", "", some_txt)

# classify emotion
class_emo = classify_emotion(some_txt, algorithm="bayes", prior=1.0)
# get emotion best fit
emotion = class_emo[,7]
# substitute NA's by "unknown"
emotion[is.na(emotion)] = "unknown"

# classify polarity
class_pol = classify_polarity(some_txt, algorithm="bayes")
# get polarity best fit
polarity = class_pol[,4]

# data frame with results
sent_df = data.frame(text=some_txt, emotion=emotion,
                     polarity=polarity, stringsAsFactors=FALSE)

# sort data frame
sent_df = within(sent_df,
                 emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))

# plot distribution of emotions
plots <- ggplot(sent_df, aes(x=emotion)) +
  geom_bar(aes(y=..count.., fill=emotion)) +
  scale_fill_brewer(palette="Dark2") +
  labs(x="emotion categories", y="number of tweets",title=paste0("Sentiment Analysis of Terrorism Tweets from ",names(data)[i],"\n(classification by emotion)")) 

ggsave(plots,filename=paste("E:/git/TerrorismPrediction/EmotionClassification/",names(data)[i],".png",sep=""))

# plot distribution of polarity
plots <- ggplot(sent_df, aes(x=polarity)) +
  geom_bar(aes(y=..count.., fill=polarity)) +
  scale_fill_brewer(palette="RdGy") +
  labs(x="emotion categories", y="number of tweets",title=paste0("Sentiment Analysis of Terrorism Tweets from ",names(data)[i],"\n(classification by polarity)")) 

ggsave(plots,filename=paste("E:/git/TerrorismPrediction/PolarityClassification/",names(data)[i],".png",sep=""))

# separating text by emotion
emos = levels(factor(sent_df$emotion))
nemo = length(emos)
emo.docs = rep("", nemo)
for (i in 1:nemo)
{
  tmp = some_txt[emotion == emos[i]]
  emo.docs[i] = paste(tmp, collapse=" ")
}

# remove stopwords
emo.docs = removeWords(emo.docs, stopwords("english"))
# create corpus
corpus = Corpus(VectorSource(emo.docs))
tdm = TermDocumentMatrix(corpus)
tdm = as.matrix(tdm)
colnames(tdm) = emos

# comparison word cloud
png(paste0("E:/git/TerrorismPrediction/ComparisonCloud/",names(data)[i],".png"), width=10, height=6, units="in", res=300)
comparison.cloud(tdm, colors = brewer.pal(nemo, "Dark2"),
                 scale = c(3,.5), random.order = FALSE, title.size = 1.5)
dev.off()


}
