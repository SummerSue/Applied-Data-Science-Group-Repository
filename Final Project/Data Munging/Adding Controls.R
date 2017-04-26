#Adding control variables to data
setwd("/Users/samgass/Documents/Columbia/Spring 2017/Applied Data Science/Project/Data")
merged_data <- read.csv("merged_data.csv")


#Creating Panel Data With City Rent and City Pricing Controls
t <- seq(from = 2138, to = 2160, by = 2)
newyork_bnb <- read.csv("nyc_2016_pnl.csv")
newyork_bnb <- newyork_bnb[-c(901:924, 1825:1848,t),]
la_bnb <- read.csv("la_2016_pnl.csv")
newyork_bnb <- newyork_bnb[,-1]
la_bnb <- la_bnb[,-1]


la_bnb$Neighborhood <- lapply(la_bnb$Neighborhood, function(x) paste(x,"(Los Angeles)", sep=""))
neworleans_bnb$Neighborhood<- lapply(neworleans_bnb$Neighborhood, function(x) paste(x,"(New Orleans)", sep=""))
newyork_bnb$Neighborhood<- lapply(newyork_bnb$Neighborhood, function(x) paste(x,"(New York)", sep="."))
newyork_bnb$Neighborhood <- as.character(newyork_bnb$Neighborhood)
neworleans_bnb$Neighborhood <- as.character(neworleans_bnb$Neighborhood)
la_bnb$Neighborhood <- as.character(la_bnb$Neighborhood)
neworleans_bnb$Date <- as.Date(neworleans_bnb$Date)
newyork_bnb$Date <- as.Date(newyork_bnb$Date)
la_bnb$Date <- as.Date(la_bnb$Date)

merged_data <- rbind(newyork_bnb, neworleans_bnb, la_bnb)
merged_data$Neighborhood <- as.character(merged_data$Neighborhood)

merged_data <- read.csv("merged_data.csv")

#Add city data

merged_data$City <- as.character(merged_data$City)
merged_data$City[merged_data$City == "New York"] <- "New York, NY"
merged_data$City[merged_data$City == "la"] <- "Los Angeles-Long Beach-Anaheim, CA"
merged_data$City[merged_data$City == "New Orleans"] <- "New Orleans, LA"


zri_city <- read.csv("nbh_condo.csv")
zri_city <- filter(zri_city, City == "New York" | City == "New Orleans" |
                     City == "Los Angeles")


zri_city <- zri_city[,-c(1,4:7)]
zri_city <- melt(zri_city)
zri_city <- as.data.frame(sapply(zri_city, function(x) gsub("X", "", x)))
zri_city$variable <- as.character(zri_city$variable)
zri_city$RegionName <- as.character(zri_city$RegionName)
zri_city$value <- as.numeric(as.character(zri_city$value))
zri_city$variable <- lapply(zri_city$variable, function(x) paste(x,"01", sep="."))
zri_city$variable <- as.character(zri_city$variable)
zri_city$variable <- as.Date(zri_city$variable, "%Y.%m.%d")

la_zri <- filter(zri_city, City == "Los Angeles")
no_zri <- filter(zri_city, City == "New Orleans")
nyc_zri <- filter(zri_city, City == "New York")



la_zri$Neighborhood <- lapply(la_zri$RegionName, function(x) paste(x,"(Los Angeles)", sep=""))
no_zri$Neighborhood<- lapply(no_zri$RegionName, function(x) paste(x,"(New Orleans)", sep=""))
nyc_zri$Neighborhood<- lapply(nyc_zri$RegionName, function(x) paste(x,"(New York)", sep="."))

zri_city <- rbind(la_zri, no_zri, nyc_zri)
zri_city <- zri_city[,-c(1:2)]

colnames(zri_city) <- c( "Date", "ZRI_SFR_CONDO", "Neighborhood")
zri_city <- filter(zri_city, Date <= as.Date("2016-12-31") &  Date >= as.Date("2016-01-01"))
zri_city$Neighborhood <- as.character(zri_city$Neighborhood)
zri_city$Date <- as.Date(zri_city$Date)
zri_city$ZRI_SFR_CONDO <- as.numeric(zri_city$ZRI_SFR_CONDO)
merged_data$Date <- as.Date(merged_data$Date)

merged_data <- left_join(merged_data, zri_city, by = c("Neighborhood", "Date"))

merged_data <- merged_data[!duplicated(merged_data[,c(2,4)]),]
