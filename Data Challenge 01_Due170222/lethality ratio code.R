#attempt at 86.1
myvars <- c("civilian.dead", "total.people.wounded")
sub1 <- condata[myvars]
total1 <- subset(sub1, total.people.wounded==0 & civilian.dead > 1)
sum1 <- sum(total1)
sum2 <- sum(condata$civilian.dead)
sum1/sum2
#81%