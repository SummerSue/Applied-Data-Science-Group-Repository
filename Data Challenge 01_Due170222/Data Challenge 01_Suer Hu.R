setwd("C:/Users/Suer Hu/Desktop/Applied_DS/Assignments/Data Challenge 01")

rm(list=ls(all=TRUE))

data <- read.csv(file = "C:/Users/Suer Hu/Desktop/Applied_DS/Assignments/Data Challenge 01/Processed/Confrontations.csv")

# Question 1
# 1.1 Replicate 86.1%
# 86.1% of dead civilians who presumably participated in confrontations 
# with federal armed forces were killed in events of "perfect lethality" 
# where there were only dead and no wounded.
sum(filter(data, 
           (federal.police.dead + federal.police.wounded + afi.dead + afi.wounded) > 0 &
             (civilian.dead + organized.crime.dead + public.prosecutor.dead) > 0 &
             (civilian.wounded + organized.crime.wounded + public.prosecutor.wounded) == 0)$civilian.dead) / 
  sum(filter(data, 
             (federal.police.dead + federal.police.wounded + afi.dead + afi.wounded) > 0)$civilian.dead)

    #Questions: 1. Filter by "confrontation with federal armed forces": I defined this as events where some of federal people died or were wounded;
    #           2. Definition of "perfect lethality": Police or non-police?  

# 1.2 Overall lethality ratio
sum(data$civilian.dead, data$orgainzed.crime.dead, data$public.prosecutor.dead) / 
  sum(data$civilian.wounded, data$orgainzed.crime.wounded, data$public.presecutor.wounded)

# 1.3 Lethality ratio for Federal Police, Navy and Army
# Federal Police
    #Questions: How to define "confrontations with federal police, navy and army
sum(data$federal.police.dead) / sum(data$federal.police.wounded)
# Navy
sum(data$navy.dead) / sum(data$navy.wounded)
#Army
sum(data$military.dead) / sum(data$military.wounded)



# Question 2

# 2.1 Is this the right metric to look at? Why or why not?
# No. 
# It does not provide information about who participated in given events. 
# Nor does it specify the how many of the dead/wounded were cuased by police and how many by crimnials.



# 2.2 What is the "lethality index" showing explicitly? What is it not showing? What is the definition assuming?
# Showing total non-police death vs total non-police wounded cases.
# 1. Not showing participants.
# 2. Not showing how many were killed by police/criminals/other reasons.
# 3. Not capturing the variance of cases where this rate can be largely different according to case category, time and location.


# 2.3 With the same available data, can you think of an alternative way to capture the same construct? Is it "better"?
# Compute the lethality rate of each case and plot the distribution of these rates against their features.


# 2.4 What additional information would you need to better understand the data?
# The dataset is basicly consisted of two kinds of variables: those describing features and the casulties of the event.
# For features of the events additional info like participants are needed; 
# For casulties of the events death/injury cause are needed;
# Events by each feature of events are too few which prevents us from understanding the relationship between causlty and event features.


# 2.5 What additional information could help you better capture the construct behind the "lethality index"
# 





