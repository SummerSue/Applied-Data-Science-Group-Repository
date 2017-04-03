chicago <- read.csv("chicagolistings.csv")
chicago_zri <- filter(zri, City == "Chicago")
neigh_chicago <- unique(chicago_zri$RegionName)
chicago$host_since <- as.Date(chicago$host_since)

chicago_bnb <- data.frame()
aird <- data.frame()
air <- data.frame()
for (i in neigh_chicago){
  aird <- data.frame()
  air <- data.frame()
  for (k in dat){ 
    hood <- filter(chicago, neighbourhood_cleansed == i) 
    aird[1,1] <- i
    aird[1,2] <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
    aird[1,3] <- as.character(k)
    air <- rbind(aird, air)
  }
  chicago_bnb <- rbind(air, chicago_bnb)
}

chicago_bnb$City <- "chicago"

#Getting Zillow Data in
library(reshape)

chicago_zri <- chicago_zri[,-c(1,3:7)]
chicago_zri <- melt(chicago_zri)
chicago_zri <- as.data.frame(sapply(chicago_zri, function(x) gsub("X", "", x)))
chicago_zri$variable <- as.character(chicago_zri$variable)
chicago_zri$RegionName <- as.character(chicago_zri$RegionName)
chicago_zri$value <- as.numeric(as.character(chicago_zri$value))
chicago_zri$variable <- lapply(chicago_zri$variable, function(x) paste(x,"01", sep="."))
chicago_zri$variable <- as.character(chicago_zri$variable)
chicago_zri$variable <- as.Date(chicago_zri$variable, "%Y.%m.%d")
colnames(chicago_zri) <- c("Neighborhood", "Date", "ZRI")
colnames(chicago_bnb) <- c("Neighborhood", "Airbnb", "Date", "City")
chicago_bnb$Date <- as.Date(chicago_bnb$Date)

chicago_bnb <- left_join(chicago_bnb, chicago_zri, by = c("Neighborhood", "Date"))
chicago_bnb <- filter(chicago_bnb, Date <= as.Date("2017-02-01"))
