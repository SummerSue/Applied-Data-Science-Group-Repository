boston <- read.csv("bostonlistings.csv")

zri <- read.csv("zri_all.csv")
boston_zri <- filter(zri, City == "Boston")

boston_hood <- unique(boston_zri$RegionName)
boston <- boston[boston$neighbourhood_cleansed %in% boston_hood, ]
boston$host_since <- as.Date(boston$host_since)

filter(boston, host_since <= as.Date("2016-01-01")) 


#Create Time List

library(timeSeries)
dat <- timeSequence(from = "2010-11-01", to="2017-02-01", by="month")
dat <- as.list(dat)
neigh <- unique(boston_zri$RegionName)


#To make into multiple data frames
for (i in neigh){
  air <- data.frame()
for (k in dat){ 
     newname <- paste(i, "data", sep="_")
     hood <- filter(boston, neighbourhood_cleansed == i) 
     aird <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
     air <- rbind(air,aird)
     assign(newname, as.data.frame(t(air)))
  }
}

#To make into one data frame

bnb <- data.frame()
bnb[1:76, ] <- NA
for (i in neigh){
  air <- data.frame()
  for (k in dat){ 
    hood <- filter(boston, neighbourhood_cleansed == i) 
    aird <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
    air <- rbind(air,aird)
  }
  colnames(air) <- i
  bnb <- cbind(air, bnb)
}

bnb <- t(bnb)
colnames(bnb) <- colnames(boston_zri)[8:83]
 