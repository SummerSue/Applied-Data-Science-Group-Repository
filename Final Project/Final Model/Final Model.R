setwd("/Users/samgass/GitHub/Applied-Data-Science-Group-Repository/Final Project/Final Model")
merged_data <- read.csv("merged_data_with_controls.csv")

library(plm)
library(systemfit)
library(lme4)


model_original <- plm(ZRI ~ bnb_lag, 
             index = c("Neighborhood","Date"), model="within", data = merged_data)
model_fixed <- plm(ZRI ~ bnb_lag + ZRI_SFR_CONDO + ZRI_City, 
                   index = c("Neighborhood","Date"), model="within", data = merged_data)
model_fixed_time <- plm(ZRI ~ bnb_lag + ZRI_SFR_CONDO + Date, 
             index = c("Neighborhood","Date"), model="within", data = merged_data)
model_random <- plm(ZRI ~ bnb_lag + ZRI_SFR_CONDO + Date + ZRI_City, 
              index = c("Neighborhood","Date"), model="random", data = merged_data)

summary(model_original)
summary(model_fixed)
summary(model_random)
summary(model_fixed_time)

fixef(model_fixed_time)

#Random Effects vs Fixed Effects

phtest(model_fixed, model_random) #Use Fixed

#Use time as variable?
pFtest(model_fixed_time, model_fixed) #Use time as variable

#Lagging

#Lagged
m <- merged_data[, c(3,5,2,4,7:9)]
pd <- pdata.frame(m)
pd$bnb_lag1 <- lag(pd$bnb_lag)
pd$bnb_lag2 <- lag(pd$bnb_lag, 2)
pd$bnb_lag3 <- lag(pd$bnb_lag, 3)
pd$bnb_lag4 <- lag(pd$bnb_lag, 4)

#One Year Lag

model_lag1<- plm(ZRI ~ bnb_lag1 + ZRI_SFR_CONDO + Date,  
                 index = c("Neighborhood","Date"), model="within", data = pd)
summary(model_lag1)
#Lag 2
model_lagged2 <- plm(ZRI ~ bnb_lag2 + Date + ZRI_SFR_CONDO, 
                     index = c("Neighborhood","Date"), model="within", data = pd)

summary(model_lagged2)

#Lag 3
model_lagged3 <- plm(ZRI ~ bnb_lag3 + Date + ZRI_SFR_CONDO, 
                     index = c("Neighborhood","Date"), model="within", data = pd)

summary(model_lagged3)

#Lag 4
model_lagged4 <- plm(ZRI ~ bnb_lag4 + Date + ZRI_SFR_CONDO, 
                     index = c("Neighborhood","Date"), model="within", data = pd)
summary(model_lagged4)




#Instrumental Variables------------------------FINAL MODEL
model_instrumental<- plm(ZRI ~ bnb_lag + Date | ZRI_City + Date, 
                        index = c("Neighborhood","Date"), model="within", data = pd)
summary(model_instrumental)

#Lagged
m <- merged_data[, c(3,5,2,4,7:9)]
pd <- pdata.frame(m)
pd$bnb_lag1 <- lag(pd$bnb_lag)
pd$bnb_lag2 <- lag(pd$bnb_lag, 2)
pd$bnb_lag3 <- lag(pd$bnb_lag, 3)
pd$bnb_lag4 <- lag(pd$bnb_lag, 4)



model_lag1<- plm(ZRI ~ bnb_lag1 + Date | ZRI_City + Date,  
                        index = c("Neighborhood","Date"), model="within", data = pd)
summary(model_lag1)
#Lag 2
instr_lagged2 <- plm(ZRI ~ bnb_lag2 + Date | ZRI_City + Date, 
                     index = c("Neighborhood","Date"), model="within", data = pd)

summary(instr_lagged2)

#Lag 3
instr_lagged3 <- plm(ZRI ~ bnb_lag3 + Date | ZRI_City + Date, 
                     index = c("Neighborhood","Date"), model="within", data = pd)

summary(instr_lagged3)

#Lag 4
instr_lagged4 <- plm(ZRI ~ bnb_lag4 + Date | ZRI_City + Date, 
                     index = c("Neighborhood","Date"), model="within", data = pd)

summary(instr_lagged4)

#Graphing Coefs


nolag <- as.data.frame(coef(summary(model_fixed_time)))
lag1 <- as.data.frame(coef(summary(model_lagged1)))
lag2 <- as.data.frame(coef(summary(model_lagged2)))
lag3 <- as.data.frame(coef(summary(model_lagged3)))
lag4 <- as.data.frame(coef(summary(model_lagged4)))

coefs <- rbind(nolag[1, ], lag1[1, ], lag2[1, ], lag3[1, ], lag4[1, ])
coefs <- coefs[, 1]
coefs <- as.data.frame(coefs)

t<- c("Same Month", "One Month", "Two Months", "Three Months", "Four Months")

coefs$time <- 0:4

#Graphing

ggplot(coefs, aes(time, coefs)) + geom_line(col = "dodgerblue3", size = 2) +
  labs(y = "Effect of Number of Airbnb on Median Rent", 
       x = "Months After Airbnb Increase", 
       caption = "(Effect is Fixed Effect Coefficient)") + theme_minimal() + 
  scale_y_continuous(limits = c(0, .3))


