#We used this as a format to take the airbnb data and zillow data and put it into
#panel data format

#Read in New Orleans Data and separate out to only NO
neworleans <- read.csv("neworleanslistings.csv")
zri <- read.csv("zri_all.csv")
neworleans_zri <- filter(zri, City == "New Orleans")

#All New Orleans Neighborhoods in Zillow File
neigh_neworleans <- unique(neworleans_zri$RegionName)
neworleans$host_since <- as.Date(neworleans$host_since)


#Create Time List (these are the dates we want)
library(timeSeries)
dat <- timeSequence(from = "2010-11-01", to="2017-02-01", by="month")
dat <- as.list(dat)
detach("package:timeSeries", unload=TRUE) #This package interferes with dplyr

#This loop takes the airbnb data and gives us the number in each neighborhood for each date
neworleans_bnb <- data.frame()
aird <- data.frame()
air <- data.frame()
for (i in neigh_neworleans){
  aird <- data.frame()
  air <- data.frame()
  for (k in dat){ 
    hood <- filter(neworleans, neighbourhood_cleansed == i) 
    aird[1,1] <- i
    aird[1,2] <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
    aird[1,3] <- as.character(k)
    air <- rbind(aird, air)
  }
  neworleans_bnb <- rbind(air, neworleans_bnb)
}

neworleans_bnb$City <- "New Orleans"

#Getting Zillow Data in
library(reshape)

neworleans_zri <- neworleans_zri[,-c(1,3:7)]
neworleans_zri <- melt(neworleans_zri) #Melt to go long to wide

#Mess with data to get in right format
neworleans_zri <- as.data.frame(sapply(neworleans_zri, function(x) gsub("X", "", x)))
neworleans_zri$variable <- as.character(neworleans_zri$variable)
neworleans_zri$RegionName <- as.character(neworleans_zri$RegionName)
neworleans_zri$value <- as.numeric(as.character(neworleans_zri$value))
neworleans_zri$variable <- lapply(neworleans_zri$variable, function(x) paste(x,"01", sep="."))
neworleans_zri$variable <- as.character(neworleans_zri$variable)
#Get correct date format
neworleans_zri$variable <- as.Date(neworleans_zri$variable, "%Y.%m.%d")
#Rename columns to merge
colnames(neworleans_zri) <- c("Neighborhood", "Date", "ZRI")
colnames(neworleans_bnb) <- c("Neighborhood", "Airbnb", "Date", "City")
neworleans_bnb$Date <- as.Date(neworleans_bnb$Date)

#Merge Airbnb and Zillow Data
neworleans_bnb <- left_join(neworleans_bnb, neworleans_zri, by = c("Neighborhood", "Date"))
#Filter to the dates we want
neworleans_bnb <- filter(neworleans_bnb, Date <= as.Date("2016-12-30") & Date >= as.Date("2016-01-01"))

#Los Angeles--------------------------------------------------------------------


#Read in Los Angeles Data and separate out to only LA
la <- read.csv("la_bnb.csv")
zri <- read.csv("zri_all.csv")
la_zri <- filter(zri, City == "Los Angeles")

#All Los Angeles Neighborhoods in Zillow File
neigh_la <- unique(la_zri$RegionName)
la$host_since <- as.Date(la$host_since)

#This loop takes the airbnb data and gives us the number in each neighborhood for each date
la_bnb <- data.frame()
aird <- data.frame()
air <- data.frame()
for (i in neigh_la){
  aird <- data.frame()
  air <- data.frame()
  for (k in dat){ 
    hood <- filter(la, neighbourhood_cleansed == i) 
    aird[1,1] <- i
    aird[1,2] <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
    aird[1,3] <- as.character(k)
    air <- rbind(aird, air)
  }
  la_bnb <- rbind(air, la_bnb)
}

la_bnb$City <- "Los Angeles"

#Getting Zillow Data in
library(reshape)

la_zri <- la_zri[,-c(1,3:7)]
la_zri <- melt(la_zri)
la_zri <- as.data.frame(sapply(la_zri, function(x) gsub("X", "", x)))
la_zri$variable <- as.character(la_zri$variable)
la_zri$RegionName <- as.character(la_zri$RegionName)
la_zri$value <- as.numeric(as.character(la_zri$value))
la_zri$variable <- lapply(la_zri$variable, function(x) paste(x,"01", sep="."))
la_zri$variable <- as.character(la_zri$variable)
la_zri$variable <- as.Date(la_zri$variable, "%Y.%m.%d")
colnames(la_zri) <- c("Neighborhood", "Date", "ZRI")
colnames(la_bnb) <- c("Neighborhood", "Airbnb", "Date", "City")
la_bnb$Date <- as.Date(la_bnb$Date)

la_bnb <- left_join(la_bnb, la_zri, by = c("Neighborhood", "Date"))
la_bnb <- filter(la_bnb, Date <= as.Date("2016-12-30") & Date >= as.Date("2016-01-01"))

#New York City-------------------------------------------------------------------


#Read in New York Data and separate out to only NYC
nyc <- read.csv("nyc_bnb.csv")
zri <- read.csv("zri_all.csv")
nyc_zri <- filter(zri, City == "New York")

#All New York Neighborhoods in Zillow File
neigh_nyc <- unique(nyc_zri$RegionName)
nyc$host_since <- as.Date(nyc$host_since)

#This loop takes the airbnb data and gives us the number in each neighborhood for each date
nyc_bnb <- data.frame()
aird <- data.frame()
air <- data.frame()
for (i in neigh_nyc){
  aird <- data.frame()
  air <- data.frame()
  for (k in dat){ 
    hood <- filter(nyc, neighbourhood_cleansed == i) 
    aird[1,1] <- i
    aird[1,2] <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
    aird[1,3] <- as.character(k)
    air <- rbind(aird, air)
  }
  nyc_bnb <- rbind(air, nyc_bnb)
}

nyc_bnb$City <- "New York"

#Getting Zillow Data in
library(reshape)

nyc_zri <- nyc_zri[,-c(1,3:7)]
nyc_zri <- melt(nyc_zri) #Melt to go long to wide

#Mess with data to get in right format
nyc_zri <- as.data.frame(sapply(nyc_zri, function(x) gsub("X", "", x)))
nyc_zri$variable <- as.character(nyc_zri$variable)
nyc_zri$RegionName <- as.character(nyc_zri$RegionName)
nyc_zri$value <- as.numeric(as.character(nyc_zri$value))
nyc_zri$variable <- lapply(nyc_zri$variable, function(x) paste(x,"01", sep="."))
nyc_zri$variable <- as.character(nyc_zri$variable)
#Get correct date format
nyc_zri$variable <- as.Date(nyc_zri$variable, "%Y.%m.%d")
#Rename columns to merge
colnames(nyc_zri) <- c("Neighborhood", "Date", "ZRI")
colnames(nyc_bnb) <- c("Neighborhood", "Airbnb", "Date", "City")
nyc_bnb$Date <- as.Date(nyc_bnb$Date)

#Merge Airbnb and Zillow Data
nyc_bnb <- left_join(nyc_bnb, nyc_zri, by = c("Neighborhood", "Date"))
#Filter to the dates we want
nyc_bnb <- filter(nyc_bnb, Date <= as.Date("2016-12-30") & Date >= as.Date("2016-01-01"))
