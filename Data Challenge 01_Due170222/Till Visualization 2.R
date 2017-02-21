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
# PL Ratios-----------------------------------------------------------------
PL.ratio <- data.frame()
PL.ratio[1:9, 1] <- c("Civilians",
                      "Federal_Police",
                      "Navy",
                      "Army",
                      "AFI",
                      "State_Police",
                      "Ministerial_Police",
                      "Municipal_Police",
                      "Public_Prosecutor")

# PL Ratio of Civilians
civ_killed_pl <- sum(filter(Pol_vs_Crime, civilian.wounded == 0,
                            organized.crime.wounded == 0)$civilian.dead)
oc_killed_pl <- sum(filter(Pol_vs_Crime, civilian.wounded == 0,
                           organized.crime.wounded == 0)$organized.crime.dead)
civ_killed <- sum(Pol_vs_Crime$civilian.dead)  
oc_killed <- sum(Pol_vs_Crime$organized.crime.dead)
PL.ratio[1, 2] <- (oc_killed_pl + civ_killed_pl) / (civ_killed + oc_killed)

# PL Ratio of Federal Police
fedpol_killed_pl <- sum(filter(Pol_vs_Crime, federal.police.wounded == 0)$
                       federal.police.dead)
fedpol_killed <- sum(Pol_vs_Crime$federal.police.dead)
PL.ratio[2, 2] <- fedpol_killed_pl / fedpol_killed

# PL Ratio of Navy
nav_killed_pl <- sum(filter(Pol_vs_Crime, navy.wounded == 0)$
                       navy.dead)
nav_killed <- sum(Pol_vs_Crime$navy.dead)
PL.ratio[3, 2] <- nav_killed_pl / nav_killed

# PL Ratio of Army
mil_killed_pl <- sum(filter(Pol_vs_Crime, military.wounded == 0)$
                       military.dead)
mil_killed <- sum(Pol_vs_Crime$military.dead)
PL.ratio[4, 2] <- mil_killed_pl / mil_killed

# PL Ratio of AFI
afi_killed_pl <- sum(filter(Pol_vs_Crime, afi.wounded == 0)$
                       afi.dead)
afi_killed <- sum(Pol_vs_Crime$afi.dead)
PL.ratio[5, 2] <- afi_killed_pl / afi_killed

# PL Ratio of State Police
stpol_killed_pl <- sum(filter(Pol_vs_Crime, state.police.wounded == 0)$
                       state.police.dead)
stpol_killed <- sum(Pol_vs_Crime$state.police.dead)
PL.ratio[6, 2] <- stpol_killed_pl / stpol_killed

# PL Ratio of Ministerial Police
minpol_killed_pl <- sum(filter(Pol_vs_Crime, ministerial.police.wounded == 0)$
                       ministerial.police.dead)
minpol_killed <- sum(Pol_vs_Crime$ministerial.police.dead)
PL.ratio[7, 2] <- minpol_killed_pl / minpol_killed

# PL Ratio of Municipal Police
munpol_killed_pl <- sum(filter(Pol_vs_Crime, municipal.police.wounded == 0)$
                       municipal.police.dead)
munpol_killed <- sum(Pol_vs_Crime$municipal.police.dead)
PL.ratio[8, 2] <- munpol_killed_pl / munpol_killed

# PL Ratio of Public Prosecutor
pp_killed_pl <- sum(filter(Pol_vs_Crime, public.prosecutor.wounded == 0)$
                       public.prosecutor.dead)
pp_killed <- sum(Pol_vs_Crime$public.prosecutor.dead)
PL.ratio[9, 2] <- pp_killed_pl / pp_killed

# Output
names(kill.ratio) <- c("Force Type", "PL Ratio")
kill.ratio$`Force Type` <- as.factor(kill.ratio$`Force Type`)

# Visualization for Lethality Index by Force Type
library(ggplot2)
ggplot(kill.ratio, aes(x = Force Type, y = PL Ratio)) +
  geom_bar(stat = "identity") +
  theme_minimal()

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
