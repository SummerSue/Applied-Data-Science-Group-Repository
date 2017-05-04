#This file merges the three cities we use in the study together--------------------------

t <- seq(from = 2138, to = 2160, by = 2)
newyork_bnb <- read.csv("nyc_2016_pnl.csv") #New York Panel Data
newyork_bnb <- newyork_bnb[-c(901:924, 1825:1848,t),]
la_bnb <- read.csv("la_2016_pnl.csv") #LA Panel Data
newyork_bnb <- newyork_bnb[,-1]
la_bnb <- la_bnb[,-1]
neworleans_bnb <- read.csv("neworleans_2016_pnl.csv") #NO Panel Data
neworleans_bnb <- neworleans_bnb[,-1]

#We added cities to the neighborhood column to avoid duplicates
la_bnb$Neighborhood <- lapply(la_bnb$Neighborhood, function(x) paste(x,"(Los Angeles)", sep=""))
neworleans_bnb$Neighborhood<- lapply(neworleans_bnb$Neighborhood, function(x) paste(x,"(New Orleans)", sep=""))
newyork_bnb$Neighborhood<- lapply(newyork_bnb$Neighborhood, function(x) paste(x,"(New York)", sep="."))
newyork_bnb$Neighborhood <- as.character(newyork_bnb$Neighborhood)
neworleans_bnb$Neighborhood <- as.character(neworleans_bnb$Neighborhood)
la_bnb$Neighborhood <- as.character(la_bnb$Neighborhood)
neworleans_bnb$Date <- as.Date(neworleans_bnb$Date)
newyork_bnb$Date <- as.Date(newyork_bnb$Date)
la_bnb$Date <- as.Date(la_bnb$Date)

#Bind all of the cities together
merged_data <- rbind(newyork_bnb, neworleans_bnb, la_bnb) #Create merged data file
merged_data$Neighborhood <- as.character(merged_data$Neighborhood)
