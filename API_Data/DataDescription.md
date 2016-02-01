## Data Description ##

This data is collected through Twitter API. I have collected this data using the REST twitter API. Being a free user I was able to fetch few tweets only as Twitter does not allow fetching all real-time tweets.

# Search Query Specifications #
Tweets are fetched based on some specifcations to tweets containing specific words for a geographical area.

1- As I was searching for tweets related to Terrorism so I searched Twitter for the terms like, 
	"Terrorism", "Terrorits", "War" etc.

2- The second criteria is the geographical location. I fetched tweets from following famous cities,
	"Washington", "Newyork", "London", "SanFrancisco", "LosAngeles", "Chicago", "Boston".

3- City wise tweets are collected by specifying latitute and longitude of the city and a radius value. I collected tweets which are tweeted within the 100 miles radius from the lat/long point.