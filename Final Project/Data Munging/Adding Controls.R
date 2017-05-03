#Adding control variables to data
setwd("/Users/samgass/Documents/Columbia/Spring 2017/Applied Data Science/Project/Data")
merged_data <- read.csv("merged_data.csv")

##This File Creates Panel Data With City Rent and City Pricing Controls-------------------

#Make names the same as in other file
merged_data$City <- as.character(merged_data$City)
merged_data$City[merged_data$City == "New York"] <- "New York, NY"
merged_data$City[merged_data$City == "la"] <- "Los Angeles-Long Beach-Anaheim, CA"
merged_data$City[merged_data$City == "New Orleans"] <- "New Orleans, LA"

#Read in condo data
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

#Add in condo rent data
la_zri <- filter(zri_city, City == "Los Angeles")
no_zri <- filter(zri_city, City == "New Orleans")
nyc_zri <- filter(zri_city, City == "New York")

#Add city names to neighborhood to avoid duplicates
la_zri$Neighborhood <- lapply(la_zri$RegionName, function(x) paste(x,"(Los Angeles)", sep=""))
no_zri$Neighborhood<- lapply(no_zri$RegionName, function(x) paste(x,"(New Orleans)", sep=""))
nyc_zri$Neighborhood<- lapply(nyc_zri$RegionName, function(x) paste(x,"(New York)", sep="."))

#Bind cities together
zri_city <- rbind(la_zri, no_zri, nyc_zri)
zri_city <- zri_city[,-c(1:2)]

#Make variables same as other dataset
colnames(zri_city) <- c("Date", "ZRI_SFR_CONDO", "Neighborhood")

#Get dates we want
zri_city <- filter(zri_city, Date <= as.Date("2016-12-31") &  Date >= as.Date("2016-01-01"))
zri_city$Neighborhood <- as.character(zri_city$Neighborhood)
zri_city$Date <- as.Date(zri_city$Date)
zri_city$ZRI_SFR_CONDO <- as.numeric(zri_city$ZRI_SFR_CONDO)
merged_data$Date <- as.Date(merged_data$Date)

#Merge data files
merged_data <- left_join(merged_data, zri_city, by = c("Neighborhood", "Date"))

#Eliminate duplicates(This happens because some cities have duplicate neighborhood names)
merged_data <- merged_data[!duplicated(merged_data[,c(2,4)]),]


#Add in city median rent data --------------------------------------------------------
zri_city <- read.csv("zri_city.csv")
zri_city <- filter(zri_city, RegionName == "Boston, MA" | RegionName == "Austin, TX" |
                     RegionName == "Los Angeles-Long Beach-Anaheim, CA" |
                     RegionName == "Denver, CO" | RegionName == "neworleans, IL")


zri_city <- zri_city[,-c(1,3)]
zri_city <- melt(zri_city)
zri_city <- as.data.frame(sapply(zri_city, function(x) gsub("X", "", x)))
zri_city$variable <- as.character(zri_city$variable)
zri_city$RegionName <- as.character(zri_city$RegionName)
zri_city$value <- as.numeric(as.character(zri_city$value))
zri_city$variable <- lapply(zri_city$variable, function(x) paste(x,"01", sep="."))
zri_city$variable <- as.character(zri_city$variable)
zri_city$variable <- as.Date(zri_city$variable, "%Y.%m.%d")
colnames(zri_city) <- c("Neighborhood", "Date", "City_ZRI")

#Merge Files
merged_data <- left_join(merged_data, zri_city, by = c("Neighborhood", "Date"))

