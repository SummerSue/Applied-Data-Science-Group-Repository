```{r}
#Data Cleaning 
setwd("C:/Users/Suer Hu/Desktop/Applied_DS/Assignments/Data Challenge 01")
rm(list=ls(all=TRUE))
fullData <- read.csv(file = "C:/Users/Suer Hu/Desktop/Applied_DS/Assignments/Data Challenge 01/Processed/Confrontations.csv")
library(dplyr)

#Finding All Police vs. Criminals Events
Pol_vs_Crime <- filter(fullData, rowSums(fullData[,11:18]) > 0 |
                         rowSums(fullData[,22:31]) > 0 | 
                         detained > 0)

#Criminal vs. Criminal Confrontations
Crime_vs_Crime <- filter(fullData, rowSums(fullData[,11:18]) == 0,
                         rowSums(fullData[,22:31]) == 0,
                         detained == 0,
                         rowSums(fullData[,c(19:20,30:31)]) > 0)
```

```{r}
# % Killed With Perfect Lethality

civ_killed_pl <- sum(filter(Pol_vs_Crime, civilian.wounded == 0,
                            organized.crime.wounded == 0)$civilian.dead)
oc_killed_pl <- sum(filter(Pol_vs_Crime, civilian.wounded == 0,
                           organized.crime.wounded == 0)$organized.crime.dead)
civ_killed <- sum(Pol_vs_Crime$civilian.dead)  
oc_killed <- sum(Pol_vs_Crime$organized.crime.dead)

(oc_killed_pl + civ_killed_pl) / (civ_killed + oc_killed)

```

```{r}
# Kill Ratios-----------------------------------------------------------------
kill.ratio <- data.frame()
kill.ratio[1:8, 1] <- c("Federal Police",
                        "Navy",
                        "Army",
                        "AFI",
                        "State Police",
                        "Ministerial Police",
                        "Municipal Police",
                        "Public Prosecutor")

# Federal Police Confrontations (3.46 dead for every wounded)

Fed_Pol <- filter(fullData, rowSums(fullData[,c(13,24)]) > 0)
kill.ratio[1, 2] <- sum(Fed_Pol[,c(19,20)]) / sum(Fed_Pol[,c(30,31)]) 

# Navy Lethality Index (7.14)

Navy <- filter(fullData, rowSums(fullData[,c(12,23)]) > 0)
kill.ratio[2, 2] <- sum(Navy[,c(19,20)]) / sum(Navy[,c(30,31)]) 

# Army Lethality Index (4.24)

Army <- filter(fullData, rowSums(fullData[,c(11,22)]) > 0)
kill.ratio[3, 2] <- sum(Army[,c(19,20)]) / sum(Army[,c(30,31)]) 

# AFI Lethality Index
AFI <- filter(fullData, rowSums(fullData[,c(14, 25)]) > 0)
kill.ratio[4, 2] <- sum(AFI[,c(19,20)]) / sum(AFI[,c(30,31)]) 


# State Police Lethality Index
State_police <- filter(fullData, rowSums(fullData[,c(15, 26)]) > 0)
kill.ratio[5, 2] <- sum(State_police[,c(19,20)]) / sum(AFI[,c(30,31)]) 

# Ministerial Police Lethality Index
Ministerial <- filter(fullData, rowSums(fullData[,c(16, 27)]) > 0)
kill.ratio[6, 2] <- sum(Ministerial[,c(19,20)]) / sum(AFI[,c(30,31)]) 

# Municipal Police Lethality Index
Municipal <- filter(fullData, rowSums(fullData[,c(17, 28)]) > 0)
kill.ratio[7, 2] <- sum(Municipal[,c(19,20)]) / sum(AFI[,c(30,31)]) 

# Public Prosecutor Lethality Index
Public_Prosecutor <- filter(fullData, rowSums(fullData[,c(18, 29)]) > 0)
kill.ratio[8, 2] <- sum(Public_Prosecutor[,c(19,20)]) / sum(AFI[,c(30,31)]) 

# Output
names(kill.ratio) <- c("Force Type", "Lethality Ratio")
kill.ratio$`Force Type` <- as.factor(kill.ratio$`Force Type`)

# Visualization for Lethality Index by Force Type
library(ggplot2)
ggplot(kill.ratio, aes(x = Force Type, y = Lethality Ratio)) +
  geom_bar(stat = "identity") +
  theme_minimal()


```




```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
