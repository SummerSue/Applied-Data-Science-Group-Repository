Creating Time Series for Queens
================

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
zillow <- read.csv("zillow2.csv")
airbnb <- read.csv("airbnb_listings.csv")

queens <- filter(airbnb, neighbourhood_group_cleansed == "Queens")

z_queens <- filter(zillow, CountyName == "Queens")
queens$host_since <- as.Date(queens$host_since)


library(timeSeries)
```

    ## Loading required package: timeDate

``` r
dat <- timeSequence(from = "2011-12-01", to="2017-01-01", by="month")
dat <- as.list(dat)
```

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

    ## Warning in `[<-`(`*tmp*`, i, value = <S4 object of class
    ## structure("timeDate", package = "timeDate")>): implicit list embedding of
    ## S4 objects is deprecated

``` r
air <- data.frame()
aird <- data.frame()

detach("package:timeSeries", unload=TRUE)

for (k in dat){
    aird<- as.data.frame(nrow(filter(queens, host_since <= as.Date(k))))
    air <- rbind(air,aird)
}

date <- t(as.data.frame(dat))
air$date <- date

zil <- z_queens[,-c(1:19)]
zil <- t(zil)
zil <- as.data.frame(zil)

air <-cbind(air,zil)

col <- c("Airbnbs", "Date", "Med_Rent")
colnames(air) <- col
air$Date <- as.Date(air$Date)
```

``` r
# Plots
library(ggplot2)
ggplot(air, aes(Date)) + geom_line(aes(y = Airbnbs), col = "blue")
```

![](Creating_Time_Series_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
ggplot(air, aes(Date)) + geom_line(aes(y = Med_Rent), col = "red")
```

![](Creating_Time_Series_files/figure-markdown_github/unnamed-chunk-2-2.png)

``` r
ggplot(air, aes(Date)) + geom_line(aes(y = Airbnbs), col = "blue") + geom_line(aes(y = Med_Rent), col = "red")
```

![](Creating_Time_Series_files/figure-markdown_github/unnamed-chunk-2-3.png)
