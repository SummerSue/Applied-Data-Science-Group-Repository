setwd("/Users/samgass/Documents/Columbia/Spring 2017/Applied Data Science/Project/Data")
merged_data <- read.csv("merged_data_with_controls.csv")

library(plm)
library(systemfit)
model_original <- plm(ZRI ~ Airbnb, 
             index = c("Neighborhood","Date"), model="within", data = merged_data)
model_fixed <- plm(ZRI ~ Airbnb + ZRI_SFR_CONDO + ZRI_City, 
                   index = c("Neighborhood","Date"), model="within", data = merged_data)
model_fixed_time <- plm(ZRI ~ Airbnb + ZRI_SFR_CONDO + Date + ZRI_City, 
             index = c("Neighborhood","Date"), model="within", data = merged_data)
model_random <- plm(ZRI ~ Airbnb + ZRI_SFR_CONDO + Date + ZRI_City, 
              index = c("Neighborhood","Date"), model="random", data = merged_data)

summary(model_original)
summary(model_fixed)
summary(model_random)
summary(model_fixed_time)

#Random Effects vs Fixed Effects

phtest(model_fixed, model_random) #Use Fixed

#Use time as variable?
pFtest(model_fixed_time, model_fixed) #Use time as variable

