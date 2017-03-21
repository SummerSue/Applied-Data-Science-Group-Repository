Question 2
================

Hypothesis 1
============

Our first hypothesis is that there will be more deaths if army was involved in the confrontation, regardless of the sacle of the combat.

The assumption is that a confrontation was of a larger scale if there were more vehicles and long guns seized in that event. This is based on 4 sub-assumptions:

1.  more vehicles and long guns seized means more vehicles and long guns were used in the confrontation
2.  more participating forces if more vehicles were used
3.  more vehicles also added complexitiy to the combat, such as explosion and defense
4.  more long guns means participants could be murdered within a longer distance

Below is an exhibition of our findings. The result demonstrates that there are more deaths if army was involved in the confrontation, regardless of the sacle of the combat, which agrees with our hypothesis.

The marginal effect of the involvement of army on deaths is 0.16, on average, ceteris paribus. And this effect is statistically significant at a 95% confidence level. The marginal effects of `vehicles.seized` and `long.guns.seized` are both positive and significant as well. The interactions show that army involvement does not have a significant effect of the marginal effect of vehicles seized, but will significantly decreases the marginal effect of long guns seized.

<table style="border-collapse:collapse; border:none;border-bottom:double;">
<td style="padding:0.2cm; border-top:double;">
 
</td>
<td style="border-bottom:1px solid; padding-left:0.5em; padding-right:0.5em; border-top:double;">
 
</td>
<td style="padding:0.2cm; text-align:center; border-bottom:1px solid; border-top:double;" colspan="3">
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
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:center; border-top:1px solid;" colspan="3">
5396
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
R<sup>2</sup> / adj. R<sup>2</sup>
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; padding-top:0.1cm; padding-bottom:0.1cm;" colspan="3">
.071 / .070
</td>
</tr>
</table>
The limitations of our interference are:

1.  the marginal effects of vehicles and long guns seized might not linear(addictive), but our model fails to detect if this is true
2.  the marginal effect of army could be so overwhelming large that our result might not differ a lot from the one that evaluate the marginal effects of army with no interactions at all
3.  there might be multicollinearity because armys use vehicles and long guns a lot

Codes
=====

``` r
all_violence <- read.csv("/Users/bobchen/Documents/Columbia/S17/5069 Applied Data Science/QMSS-GR5069/week_07/datachallenge2/data/processed/AllViolenceData_170216.csv")

lm1 <- lm(total.people.dead ~ army + vehicles.seized * army + long.guns.seized * army, data = all_violence)
library(sjPlot)
sjt.lm(lm1, show.ci = FALSE, show.se = TRUE)
```
