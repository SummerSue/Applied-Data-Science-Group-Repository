Data Challenge 2 --- Group 5
================

#Question 1 Part 1

Does the presence of perfect lethality by the government agencies in a conflict prevent government deaths?

```{r, warning = FALSE, message = FALSE, echo = FALSE}
#Data Transformations
library(dplyr)
data <- read.csv("AllViolenceData_170216.csv")

#Create variable for total deaths for all government agencies
data <- mutate(data, total.force.dead = state.police.dead + municipal.police.dead  + 
                                        federal.police.dead + afi.dead + navy.dead +
                                        ministerial.police.dead + military.dead    +
                                        public.prosecutor.dead)

#Remove cases with no deaths and wounded. This separates out events with no conflict. 

data <- filter(data, total.people.dead > 0, total.people.wounded > 0)

#Create month variables to control for seasonal variability
library(lubridate)
data$force.dead <- ifelse(data$total.force.dead > 0, 1, 0)
data$date <- as.Date(data$date)
data$month <- month(data$date)
data <- mutate(data, MonthAbb = month.abb[month])
```

To answer this question we performed a logistic regression with force.dead (if there were any deaths on the side of the government) as the dependent variable and perfect lethality (if the government forces executed with perfect lethality) as the independent variable. To control for seasonal variability and location, we controlled for month of the year and state as well. The results of the regression are as follows:

```{r, warning = FALSE, message = FALSE, echo = FALSE}
#Logistic regression model
log <- glm(force.dead ~ perfect.lethality + state + MonthAbb , data = data, family = "binomial")
library(sjPlot)
sjt.lm(log, show.se = TRUE)
coef <- as.data.frame(coefficients(log))
exp(coef[2,1])
```

These results indicate that if the government operates with perfect lethality, they reduce the  odds of the government incurring a death in an event with conflict by 42% controlling for location and time of year, the effect is statistically significant at the p<.001 level.  

This analysis indicates a very significant drop in conflict events with government deaths if the government executes with perfect lethality. Plot 1 indicates that the government incurs a casualty in a much smaller portion of the events where perfect lethality is used. This is a very important relationship to examine and we would highly recommend further study; if perfect lethality prevents government deaths it would partially explain its frequency in these conflicts (the government agencies would have a lot of incentive to act more lethally if it prevents deaths on their side). At the same time, these government run organizations have a civic duty to reduce the number of people killed in raids. This creates an interesting dynamic between two opposing forces; the government agencies that conduct these raids and the government oversight organizations responsible for good governance. The former would probably support using more lethal force if it prevents deaths of their own people, the latter would probably push the agencies to reduce their lethality to prevent human rights abuses. There are limitations to this analysis; the sample is bias towards events with no deaths. This is hard to overcome as the events just occur in this distribution. Overall, this analysis gives valuable insight into a difficult subject and suggests that further study would be beneficial.

```{r, warning = FALSE, message = FALSE, echo = FALSE}
library(ggplot2)
library(dplyr)
library(ggthemes)

data$dead <- ifelse(data$total.force.dead > 0, 1, 0)

data$perf.leth <- ifelse(data$perfect.lethality == 0, "Not Perfectly Lethal", 
                          "Perfectly Lethal")
data$dead <- ifelse(data$force.dead == 0, "No Deaths", "At Least One Dead")

bardata <- data %>% 
  group_by(dead, perf.leth) %>%
  summarise(count = n())

bardata$percentage <- c("42%", "23%", "58%", "77%")

ggplot(bardata, aes(x = perf.leth, 
                    y = count,
                    fill = dead)) + 
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = percentage), vjust = 0.2, color = "black", position=position_dodge(.9)) +
  ggtitle("Effect of Perfect Lethality on Government Deaths") +
  theme_economist() + scale_fill_tableau() +
  labs(x = "", y = "", caption = "Plot 1") + 
  theme(plot.title = element_text(hjust = .5),
        legend.title = element_blank())
  
```

```{r, eval = FALSE}
#Data Transformations
library(dplyr)
data <- read.csv("AllViolenceData_170216.csv")

#Create variable for total deaths for all government agencies
data <- mutate(data, total.force.dead = state.police.dead + municipal.police.dead  + 
                                        federal.police.dead + afi.dead + navy.dead +
                                        ministerial.police.dead + military.dead    +
                                        public.prosecutor.dead)

#Remove cases with no deaths and wounded. This separates out events with no conflict. 

data <- filter(data, total.people.dead > 0, total.people.wounded > 0)

#Create month variables to control for seasonal variability
library(lubridate)
data$force.dead <- ifelse(data$total.force.dead > 0, 1, 0)
data$date <- as.Date(data$date)
data$month <- month(data$date)
data <- mutate(data, MonthAbb = month.abb[month])


#Logistic regression model
log <- glm(force.dead ~ perfect.lethality + state + MonthAbb , data = data, family = "binomial")
library(sjPlot)
sjt.lm(log, show.se = TRUE)
coef <- as.data.frame(coefficients(log))
exp(coef[2,1])

library(ggplot2)
library(dplyr)
library(ggthemes)

data$dead <- ifelse(data$total.force.dead > 0, 1, 0)

data$perf.leth <- ifelse(data$perfect.lethality == 0, "Not Perfectly Lethal", 
                          "Perfectly Lethal")
data$dead <- ifelse(data$force.dead == 0, "No Deaths", "At Least One Dead")

bardata <- data %>% 
  group_by(dead, perf.leth) %>%
  summarise(count = n())

bardata$percentage <- c("42%", "23%", "58%", "77%")

ggplot(bardata, aes(x = perf.leth, 
                    y = count,
                    fill = dead)) + 
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = percentage), vjust = 0.2, color = "black", position=position_dodge(.9)) +
  ggtitle("Effect of Perfect Lethality on Government Deaths") +
  theme_economist() + scale_fill_tableau() +
  labs(x = "", y = "", caption = "Plot 1") + 
  theme(plot.title = element_text(hjust = .5),
        legend.title = element_blank())
```


Question 2
==========

Hypothesis 1
------------

Our first hypothesis is that there will be more deaths if army was involved in the confrontation, regardless of the sacle of the combat.

#### Assumptions

The assumption is that a confrontation was of a larger scale if there were more vehicles and long guns seized in that event. This is based on 4 sub-assumptions:

1.  more vehicles and long guns seized means more vehicles and long guns were used in the confrontation
2.  more participating forces if more vehicles were used
3.  more vehicles also added complexitiy to the combat, such as explosion and defense
4.  more long guns means participants could be murdered within a longer distance

#### Computations

The marginal effect referenced was the "B" column provided by the regression model and is interpreted as described in the marginal effect section above. To arrive at standard error and confidence intervals by running OLS, the results are reflected in "std.Error" and "CI" columns, respectively, the CIs are 95% confidence interval. Computation methods for hypothesis 1 and 2 are the same.

#### Findings

Below is an exhibition of our findings. The result demonstrates that there are more deaths if army was involved in the confrontation, regardless of the sacle of the combat, which agrees with our hypothesis.

The marginal effect of the involvement of army on deaths is 0.16(95% confidence interval range of .03 to .28), on average, ceteris paribus. And this effect is statistically significant at a 95% confidence level. The marginal effects of `vehicles.seized` and `long.guns.seized` are both positive and significant as well. The interactions show that army involvement does not have a significant effect of the marginal effect of vehicles seized, but will significantly decreases the marginal effect of long guns seized.

<table style="border-collapse:collapse; border:none;border-bottom:double;">
<td style="padding:0.2cm; border-top:double;">
 
</td>
<td style="border-bottom:1px solid; padding-left:0.5em; padding-right:0.5em; border-top:double;">
 
</td>
<td style="padding:0.2cm; text-align:center; border-bottom:1px solid; border-top:double;" colspan="4">
total.people.dead
</td>
</tr>
<tr>
<td style="padding:0.2cm; font-style:italic;">
 
</td>
<td style="padding-left:0.5em; padding-right:0.5em; font-style:italic;">
 
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
B
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
CI
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
std. Error
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
p
</td>
</tr>
<tr>
<td style="padding:0.2cm; border-top:1px solid; text-align:left;">
(Intercept)
</td>
<td style="padding-left:0.5em; padding-right:0.5em; border-top:1px solid; ">
 
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
0.93
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
0.86 – 1.00
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
0.04
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
army
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.16
</td>
<td style="padding:0.2cm; text-align:center; ">
0.03 – 0.28
</td>
<td style="padding:0.2cm; text-align:center; ">
0.07
</td>
<td style="padding:0.2cm; text-align:center; ">
.017
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
vehicles.seized
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.01
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.00 – 0.02
</td>
<td style="padding:0.2cm; text-align:center; ">
0.01
</td>
<td style="padding:0.2cm; text-align:center; ">
.054
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
long.guns.seized
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.20
</td>
<td style="padding:0.2cm; text-align:center; ">
0.17 – 0.22
</td>
<td style="padding:0.2cm; text-align:center; ">
0.01
</td>
<td style="padding:0.2cm; text-align:center; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
army:vehicles.seized
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.00
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.01 – 0.02
</td>
<td style="padding:0.2cm; text-align:center; ">
0.01
</td>
<td style="padding:0.2cm; text-align:center; ">
.763
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
army:long.guns.seized
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.12
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.15 – -0.09
</td>
<td style="padding:0.2cm; text-align:center; ">
0.01
</td>
<td style="padding:0.2cm; text-align:center; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;">
Observations
</td>
<td style="padding-left:0.5em; padding-right:0.5em; border-top:1px solid;">
 
</td>
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:center; border-top:1px solid;" colspan="4">
5396
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
R<sup>2</sup> / adj. R<sup>2</sup>
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; padding-top:0.1cm; padding-bottom:0.1cm;" colspan="4">
.071 / .070
</td>
</tr>
</table>
#### Limitations

The limitations of our interference are:

1.  the marginal effects of vehicles and long guns seized might not linear(addictive), but our model fails to detect if this is true
2.  the marginal effect of army could be so overwhelming large that our result might not differ a lot from the one that evaluate the marginal effects of army with no interactions at all
3.  there might be multicollinearity because armys use vehicles and long guns a lot

Hypothesis 2
------------

Our conditional hypothesis is that the total number of people dead is conditional upon the interaction between which federal force was involved and how many people were detained. We predict that if the army/navy/federal police is involved in an event each additional person detained results in a lower number of total people dead on average. The rational behind this prediction is that if there an event with federal forces ends with detained people, it is likely to be less deadly. Below is the multi-variate regression model with interactions to test this hypothesis:

#### Assumptions

`navy`, `army`, and `federal police` are binary variables in which 1 = they were involved in an event and 0 = they were not involved in an event. `total.people.dead` and `detained` are numeric variables in that increase by one from 0 up each representing an additonal person dead or detained. Additionally in order to preform the analysis we assumed that in each event only the army, navy, or federal police were present alone at each event.

<table style="border-collapse:collapse; border:none;border-bottom:double;">
<td style="padding:0.2cm; border-top:double;">
 
</td>
<td style="border-bottom:1px solid; padding-left:0.5em; padding-right:0.5em; border-top:double;">
 
</td>
<td style="padding:0.2cm; text-align:center; border-bottom:1px solid; border-top:double;" colspan="4">
total.people.dead
</td>
</tr>
<tr>
<td style="padding:0.2cm; font-style:italic;">
 
</td>
<td style="padding-left:0.5em; padding-right:0.5em; font-style:italic;">
 
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
B
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
CI
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
std. Error
</td>
<td style="padding:0.2cm; text-align:center; font-style:italic; ">
p
</td>
</tr>
<tr>
<td style="padding:0.2cm; border-top:1px solid; text-align:left;">
(Intercept)
</td>
<td style="padding-left:0.5em; padding-right:0.5em; border-top:1px solid; ">
 
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
1.04
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
0.96 – 1.12
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
0.04
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
navy
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.44
</td>
<td style="padding:0.2cm; text-align:center; ">
0.07 – 0.81
</td>
<td style="padding:0.2cm; text-align:center; ">
0.19
</td>
<td style="padding:0.2cm; text-align:center; ">
.019
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
army
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.38
</td>
<td style="padding:0.2cm; text-align:center; ">
0.24 – 0.51
</td>
<td style="padding:0.2cm; text-align:center; ">
0.07
</td>
<td style="padding:0.2cm; text-align:center; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
federal.police
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.25
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.45 – -0.04
</td>
<td style="padding:0.2cm; text-align:center; ">
0.10
</td>
<td style="padding:0.2cm; text-align:center; ">
.018
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
detained
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.04
</td>
<td style="padding:0.2cm; text-align:center; ">
0.00 – 0.08
</td>
<td style="padding:0.2cm; text-align:center; ">
0.02
</td>
<td style="padding:0.2cm; text-align:center; ">
.034
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
navy:detained
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.17
</td>
<td style="padding:0.2cm; text-align:center; ">
0.08 – 0.26
</td>
<td style="padding:0.2cm; text-align:center; ">
0.05
</td>
<td style="padding:0.2cm; text-align:center; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
army:detained
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.09
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.14 – -0.04
</td>
<td style="padding:0.2cm; text-align:center; ">
0.03
</td>
<td style="padding:0.2cm; text-align:center; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
federal.police:detained
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.06
</td>
<td style="padding:0.2cm; text-align:center; ">
0.00 – 0.12
</td>
<td style="padding:0.2cm; text-align:center; ">
0.03
</td>
<td style="padding:0.2cm; text-align:center; ">
.044
</td>
</tr>
<tr>
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;">
Observations
</td>
<td style="padding-left:0.5em; padding-right:0.5em; border-top:1px solid;">
 
</td>
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:center; border-top:1px solid;" colspan="4">
5396
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
R<sup>2</sup> / adj. R<sup>2</sup>
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; padding-top:0.1cm; padding-bottom:0.1cm;" colspan="4">
.017 / .016
</td>
</tr>
</table>
#### Marginal Effects

**Intercept** The intercept in the regression output above shows that if no navy, army, or federal police were involved an if no one was detained, the average number of total people dead is 1.03. **Coeffiencts** Given this is a conditional interaction, the model shows that if the navy is involved and no one is detained on average .43 (95% confidence interval range of .06 to .84) more people killed overall, holding all other variables constant with statistical signifiance (p-value of at least .05). If the army is involved and no one is detained on average .37 (95% confidence interval range of .25 to .52) more people killed overall, holding all other variables constant with statistical signifiance (p-value of at least .05). If the federal police is involved and no one is detained on average -.25 (95% confidence interval range of -.47 to -.05) less people killed overall, holding all other variables constant with statistical signifiance (p-value of at least .05). Additionally for each additional detained person when no one from the navy, army, or federal police is involved on average .04 (95% confidence interval range of .02 to .06) more people killed overall, holding all other variables constant with statistical signifiance (p-value of at least .05). **Interactions** The interation terms show that if the navy is involved, each additional detained person recorded in the event results in on average .17 (95% confidence interval of .07 to .26) more people killed overall , holding all other variables constant with statistical signifiance (p-value of at least .05). If the army is involved, each additional detained person recorded in the event results in on average -.09 (95% confidence interval of -.15 to -.03) less people killed overall , holding all other variables constant with statistical signifiance (p-value of at least .05). Finally if the federal police are involved each additional detained person recorded in the event results in on average .06 (95% confidence interval of .00 to .12) more people killed overall, holding all other variables constant with statistical signifiance (p-value of at least .05).
**Conclusion** The hypothesis stated proved to be partial true per the data. In the case of the navy and federal police, each indivial detained person recorded actual resulted in an increase in average overall deaths which is contrary to the prediction. In the case of the army, each individual detained person recorded resulted in a decrease in average overall deaths.

#### Limitations

The data is limited as the data is only provides information for a few year period of time in certain locations in mexico. The regression focuses on total people dead and did not segregate the analysis by which type of person died in each event.As such more detailed analysis would have to be preformed to get more insight on what type of person dies as more people are detained by certain armed forces. Additionally it is possible that the army, navy, and federal police were all at certain events which would complicate the analysis of the data as they are interrelated.

Codes
=====

``` r
all_violence <- read.csv("/Users/bobchen/Documents/Columbia/S17/5069 Applied Data Science/QMSS-GR5069/week_07/datachallenge2/data/processed/AllViolenceData_170216.csv")

lm1 <- lm(total.people.dead ~ army + vehicles.seized * army + long.guns.seized * army, data = all_violence)
library(sjPlot)
sjt.lm(lm1, show.se = TRUE)

lm2 <- lm(total.people.dead ~ navy + army + federal.police + detained + detained * navy + detained * army + detained * federal.police, data = all_violence)
sjt.lm(lm2, show.se = TRUE)
```
