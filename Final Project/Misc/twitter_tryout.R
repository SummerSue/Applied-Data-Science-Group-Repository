setwd("C:/Users/Suer Hu/Desktop/Applied_DS/Group Project/Group Project/R_Twitter Scraping")


## Get Twitter containing "Trump" for the last 30 minutes
library(ROAuth)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "BEoDWQpDxWvjVAqjkuuNBSnxZ" 
consumerSecret <- "pHYvbYnZam8yIoJMbBD7zq75ehJUICzusLMwj4JUYAvuQyLHdX" 
# My ConsumerSecret from dev.twitter.com
my_oauth <- OAuthFactory$new(consumerKey = consumerKey,
                             consumerSecret = consumerSecret,
                             requestURL = requestURL,
                             accessURL = accessURL,
                             authURL = authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))


## Store tweets and write ouput csv
library(streamR)
filterStream(file.name = "tweets_keyword.json", track = c("trump"),
             language = "en", timeout = 1800, oauth = my_oauth)   #by 20170308 13:58-14:28
tweets <- parseTweets("tweets_keyword.json", verbose = TRUE)
write.csv(tweets, fileEncoding = "twitterdata.RData")
write.csv(tweets, file = "twitter_tryout.csv")
text <- tweets[ , 1]

## Filter out tweets that retweets specific Trump tweet
library(stringr)

## Basic sentiment analysis
clean.tweets <- function(text){
  lapply(c("tm", "Rstem", "stringr"), require, c = T, q = T)
  words <- removePunctuation(text)
  words <- stemDocument(words)
  words <- str_split(text, " ")
  return(words)
}

classify <- function(words, pos.words, neg.words){
  pos.matches <- sum(words %in% pos.words)
  neg.matches <- sum(words %in% neg.words)
  return(pos.matches - neg.matches)
}

classifier <- function(tweets, pos.words, neg.words){
  words <- clean.tweets(tweets$text)
  scores <- unlist(lapply(words, classify, pos.words, neg.words))
  n <- length(scores)
  positive <- as.integer(length(which(scores > 0)) / n * 100)
  negative <- as.integer(length(which(scores < 0)) / n * 100)
  neutral <- 100 - positive - negative
  cat(n, "tweets about Trump:", positive, "% positive,",
      negative, "% negative,", neutral, "% neutral")
}


# loading lexicon of positive and negative words
# lexicon <- read.csv("C:/Users/HK/Desktop/Columbia/2016 Fall/QMSS 4058-Data Mining/G4058_Final Project/Twitter API/lexicon.csv", stringsAsFactors = F)
# pos.words <- lexicon$word[lexicon$polarity == "positive"]
# neg.words <- lexicon$word[lexicon$polarity == "negative"]

# classifier(tweets, pos.words, neg.words)



## Frequency analysis
library(tm)
text <- as.data.frame(text[ , 2])
text.raw <- Corpus(DataframeSource(text))
text.raw <- tm_map(text.raw, content_transformer(tolower))
text.raw <- tm_map(text.raw, removeNumbers)
text.raw <- tm_map(text.raw, removePunctuation)
text.raw <- tm_map(text.raw, removeWords, stopwords("english"))
text.raw <- tm_map(text.raw, stemDocument)
text.dtm <- DocumentTermMatrix(text.raw)

findFreqTerms(text.dtm, lowfreq = 600)

findFreqTerms(text.dtm, lowfreq = 300)

library(Matrix)
library(wordcloud2)
dtm.Mat <- sparseMatrix(text.dtm$i, text.dtm$j, x = text.dtm$v, dims = c(text.dtm$nrow, text.dtm$ncol), dimnames = text.dtm$dimnames)
FreqMat <- data.frame(ST = colnames(dtm.Mat), Freq = colSums(dtm.Mat))
wordcloud2(data = FreqMat[-12362, ], minSize = 5)






