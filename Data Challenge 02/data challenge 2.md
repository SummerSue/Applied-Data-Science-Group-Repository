---
title: "data challenge 2"
author: "Miriam McKinney"
date: "March 21, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
library(ggmap)
library(raster)
library(ggplot2)
confrontations <- read.csv("~/Documents/COLSP17 Applied/confrontations.csv", comment.char="#")
levels(confrontations$state)
state <- c("Aguascalientes", "Baja California", "Baja California Sur", "Campeche", "Coahuila de Zaragoza", "Colima", "Chiapas", "Chihuahua", "Ciudad de México", "Durango", "Guanajuato", "Guerrero", "Hidalgo", "Jalisco", "Mexico", "Michoacan de Ocampo", "Morelos", "Nayarit", "Nuevo Leon", "Oaxaca", "Puebla", "Queretaro", "Quintana Roo", "San Luis Potosi", "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz de Ignacio de la Llave", "Yucatan", "Zacatecas")
geo.state <- geocode(state)
state.x <- geo.state$lon
state.y <- geo.state$lat
df1 <- data.frame(state.x, state.y)
DF1 <- cbind(state, df1)
state1 <- merge(DF1, confrontations, by = c("state"))
mexicomap1 <- get_map(location= 'mexico city', zoom = 3, maptype = "terrain", source = 'google')
mexicocity1 <- ggmap(mexicomap1) + geom_point(aes(x = state.x, y = state.y), data = state1, size = 0.3, alpha = 0.3, color = "red") 
mexicomap2 <- get_map(location= 'mexico city', zoom = 5, maptype = "terrain", source = 'google')
mexicocity2 <- ggmap(mexicomap2) + geom_point(aes(x = state.x, y = state.y), data = state1, size = 0.3, alpha = 0.3, color = "red") 
mexicocity3 <- mexicocity2 + geom_density2d(data = state1, aes(x = state.x, y = state.y)) +
stat_density2d(data = state1, aes(x = state.x, y = state.y,  fill =..level.., alpha =..level..),
size = 0.01, bins = 25, geom = 'polygon') +
scale_fill_gradient(low = "green", high = "red") +
scale_alpha(range = c(0.00, 0.25), guide = FALSE) +
theme(legend.position = "none", axis.title = element_blank(), text = element_text(size = 12)) +
ggtitle("Plot Density of Interactions")
closetoborder <- c("Nuevo Leon", "Chihuahua", "Coahuila de Zaragoza", "Ciudad de Mexico") #these are the states closest to the U.S. border
farfromborder <- c("Aguascalientes", "Baja California", "Baja California Sur", "Campeche", "Colima", "Chiapas", "Durango", "Guanajuato", "Guerrero", "Hidalgo", "Jalisco", "México", "Michoacán de Ocampo", "Morelos", "Nayarit", "Oaxaca", "Puebla", "Querétaro", "Quintana Roo", "San Luis Potosí", "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz de Ignacio de la Llave", "Yucatán", "Zacatecas")
#state1$close <- values[match(state1$state, closetoborder)]
#lm1 <- lm(state1$total.people.dead ~ state1$close, data = state1)
#summary(lm1) #must adjust problems
state1$borderclose <- ifelse(state1$state == c("Nuevo Leon", "Chihuahua", "Coahuila de Zaragoza", "Ciudad de Mexico"), 1, 0)
bordermodel <- glm(state1$borderclose ~ state1$detained + state1$total.people.dead + state1$total.people.wounded, family = binomial(link = "logit"), data = state1)
summary(bordermodel)
```

Question 2: Does violence or being detained act as a function of distance from the border to the U.S.? Is the more activity closer to the border?

*- Perform necessary transformation in data* The necessary transformation was to create a new variable that represents border closeness.
*- Print output from analysis* According to the *mexicocity3* plot, there seems to be a high density of activity close to the border (as aforementioned and hypothesized).
*- What are the limitations of the analysis?* The limitations of this analysis are that it is not exact, because "closest states to the border" was allocated to certain states according to a ggmap plot of points --rather than with a precise calculation (which can be created through the *raster* package or another distance-measuring package). Also, by designating the binary variable *borderclose* to only encapsulate 4 states we might be limiting ourselves in size.
*- Anything interesting? Is this worth pursuing?* We thought that perhaps violence or imprisonment might be a function of U.S. border closeness. According to the multiple logistic regression of variables on predictor variable border-closeness, *detained* was statistically significant (p < 0.008). The negative coefficient for this variable suggests that all other variables equal, those who are detained are less likely to be close to the U.S./Mexico border. For every one unit change in *detained*, the log odds of being near the border decreases by 0.101. This could be because when you are near the border, your interactions with the police are more likely to be violence (thus, leading to death rather than being detained). Also, the null devience (which shows how well the response variable is predicted by a model that includes only the intercept) is different than the residual deviance by a 10.1 point decrease and loss of only 3 degrees of freedom.
*- Provide code and a visualization* (Mexico City 3 graph)
*- One sentence to summarize insight, one paragraph to reflect nuance in insight* The results are fairly consistent with what we believed our findings would be, although we also suspected that perhaps increased violence might be a function of border closeness. You are less likely to be close to the border when you are detained. The theory about how the data might act as a function of distance from the U.S. border is an interesting one, and perhaps there will be more evidence to support this theory somewhere within the data after addressing the limitations. 