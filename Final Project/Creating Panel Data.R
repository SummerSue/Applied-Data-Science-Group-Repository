
austin_bnb <- data.frame()
aird <- data.frame()
air <- data.frame()
for (i in neigh_aus){
  aird <- data.frame()
  air <- data.frame()
  for (k in dat){ 
    hood <- filter(austin, neighbourhood == i) 
    aird[1,1] <- i
    aird[1,2] <- as.data.frame(nrow(filter(hood, host_since <= as.Date(k))))
    aird[1,3] <- as.character(k)
    air <- rbind(aird, air)
  }
  austin_bnb <- rbind(air, austin_bnb)
}

austin_bnb$city <- "Austin"

#Getting Zillow Data in
library(reshape)
austin_zri <- filter(zri, City == "Austin")
austin_zri <- austin_zri[,-c(1,3:7)]
austin_zri <- melt(austin_zri)
austin_zri <- as.data.frame(sapply(austin_zri, function(x) gsub("X", "", x)))
austin_zri$variable <- as.character(austin_zri$variable)
austin_zri$RegionName <- as.character(austin_zri$RegionName)
austin_zri$value <- as.numeric(austin_zri$value)
austin_zri$variable <- lapply(austin_zri$variable, function(x) paste(x,"01", sep="."))
austin_zri$variable <- as.character(austin_zri$variable)
austin_zri$variable <- as.Date(austin_zri$variable, "%Y.%m.%d")
colnames(austin_zri) <- c("Neighborhood", "Date", "ZRI")
colnames(austin_bnb) <- c("Neighborhood", "Airbnb", "Date", "City")
austin_bnb$Date <- as.Date(austin_bnb$Date)

test <- left_join(austin_bnb, austin_zri, by = c("Neighborhood", "Date"))
