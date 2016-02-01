# Terrorism Prediction through Twitter Analysis #

Nowadays social media is creating a great impact. Any incident is witnessed on social media before recording organizations, even the weather changes are noticed on social media before any weather forecasting agency measured them.

It was noticed that before the weather forecasts could detect Hurricane, a tweet was present on twitter telling the occurance of Hurricane. Keeping this reality in mind, I invented a way of using Twitter in predicting the biggest problem of this era i.e. TERRORISM.

If twitter can predict an storm than it must be able to give information related to an event which is based on Human emotions. Terrorism is a result of an Human's emotional thoughts. So I have developed an algorithm to measure the "Negative emotions' level" from tweets of a particular area which will be used to predict the possibility of occuring a Terrorist activity in that area.

## ALGORITHMIC STEPS ##
1- I made a dictionary of terrorism words. For each word I fetched the tweets containing those words for specified Geographical locations.

2- Twitter REST API is used for fetching tweets.

3- Famous cities are used for getting geography based tweets. Geographical locations are specified by the Latitude/Longitude of city and a radius value.

4- Each query fetches dictionary matching tweets from the specified Geographical area.

5- The collected tweet data is uploaded [here](https://github.com/YumnaBatool/TerrorismPrediction/tree/master/API_Data).

6- Sentiment Analysis of tweets is performed to define emotions for tweet words. Few examples of the emotion based wordcloud are present [at](https://github.com/YumnaBatool/TerrorismPrediction/tree/master/ComparisonCloud).

7- The polarity of tweets is identified from the presence of "Negative" and "Positive" words in the tweets. Graphs showing Polarity of Tweets are present [at](https://github.com/YumnaBatool/TerrorismPrediction/tree/master/PolarityClassification).

8- The level of Happiness, Sadness, Anger and other emotions of each post is also calculated from sentiment analysis. Examples can be seen [at](https://github.com/YumnaBatool/TerrorismPrediction/tree/master/EmotionClassification).

9- For an occured Terrorism activity (e.g. Paris Attacks) tweets will be gathered before the event date (e.g. 13th November,2015) from the specific location (e.g. Paris). Their anger level will be identified and anger level which causes that terrorist activity is noted. This level will be used as the threshold level causing Terrorism.

10- Same analysis will be performed at real-time tweets of various cities to be monitered. City having anger level more the recorded threshold will have high probability of having a terrorist activity.

Note: This study is very practical and can be verified by getting tweets before the Paris attack. Being a free user I was unable to get enough tweets before Paris Attacks. So, I collected Tweets from various famous cities.