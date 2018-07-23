library(NLP)
library(tm)
library(ngram)
library(data.table)
library(dplyr)

blog <- readLines(con = "final/en_US/en_US.blogs.txt", skipNul = T)
news <- readLines(con = "final/en_US/en_US.news.txt", skipNul = T)
twitter <- readLines(con = "final/en_US/en_US.twitter.txt", skipNul = T)


blogsample<- sample(blog,length(blog)*0.05)
newssample<- sample(news,length(news)*0.05)
twittersample<- sample(twitter,length(twitter)*0.05)

textsample<-c(blogsample,newssample,twittersample)

cleantextsample<-Corpus(VectorSource(list(textsample)))
cleantextsample<-tm_map(cleantextsample, removeNumbers)
cleantextsample<-tm_map(cleantextsample, removePunctuation)
cleantextsample<-tm_map(cleantextsample, stripWhitespace)
cleantextsample<-tm_map(cleantextsample, PlainTextDocument)
cleantextsample<-tm_map(cleantextsample, content_transformer(tolower))
cleantextsample<-tm_map(cleantextsample, removeWords, stopwords("english"))

cleantextsamplestring<-as.String(cleantextsample)
unogram<- ngram_asweka(cleantextsamplestring,1,1)
bigram<- ngram_asweka(cleantextsamplestring,2,2)
trigram<- ngram_asweka(cleantextsamplestring,3,3)

testunigram<-TermDocumentMatrix(cleantextsample, control = list(tokenize = unogram))
testbigram<-TermDocumentMatrix(cleantextsample, control = list(tokenize = bigram))
testtrigram<-TermDocumentMatrix(cleantextsample, control = list(tokenize = trigram))

freqTerms1 <- findFreqTerms(testunigram, lowfreq = 5)
termFreq1 <- rowSums(as.matrix(testunigram[freqTerms1,]))
termFreq1 <- data.frame(unigram=names(termFreq1), frequency=termFreq1)
termFreq1 <- termFreq1[order(-termFreq1$frequency),]
unigramlist <- setDT(termFreq1)
save(unigramlist,file="unogram.Rda")
freqTerms2 <- findFreqTerms(testbigram, lowfreq = 3)
termFreq2 <- rowSums(as.matrix(testbigram[freqTerms2,]))
termFreq2 <- data.frame(bigram=names(termFreq2), frequency=termFreq2)
termFreq2 <- termFreq2[order(-termFreq2$frequency),]
bigramlist <- setDT(termFreq2)
save(bigramlist,file="bigram.Rda")
freqTerms3 <- findFreqTerms(testtrigram, lowfreq = 2)
termFreq3 <- rowSums(as.matrix(testtrigram[freqTerms3,]))
termFreq3 <- data.frame(trigram=names(termFreq3), frequency=termFreq3)
trigramlist <- setDT(termFreq3)
save(trigramlist,file="trigram.Rda")
