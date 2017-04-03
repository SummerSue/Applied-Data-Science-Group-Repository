
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

