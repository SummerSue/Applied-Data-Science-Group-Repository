Data Challenge 2
================
Sam Gass
3/21/2017

Question 1 Part 1
=================

Does the presence of perfect lethality by the government agencies in a conflict prevent government deaths?

To answer this question we performed a logistic regression with force.dead (if there were any deaths on the side of the government) as the dependent variable and perfect lethality (if the government forces executed with perfect lethality) as the independent variable. To control for seasonal variability and location, we controlled for month of the year and state as well. The results of the regression are as follows:

<table style="border-collapse:collapse; border:none;border-bottom:double;">
<td style="padding:0.2cm; border-top:double;">
 
</td>
<td style="border-bottom:1px solid; padding-left:0.5em; padding-right:0.5em; border-top:double;">
 
</td>
<td style="padding:0.2cm; text-align:center; border-bottom:1px solid; border-top:double;" colspan="4">
force.dead
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
1.48
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
-0.04 – 3.45
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
0.85
</td>
<td style="padding:0.2cm; text-align:center; border-top:1px solid; ">
.081
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
perfect.lethality
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.86
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.15 – -0.57
</td>
<td style="padding:0.2cm; text-align:center; ">
0.15
</td>
<td style="padding:0.2cm; text-align:center; ">
&lt;.001
</td>
</tr>
<tr>
<td style="padding:0.2cm;" colspan="6">
state
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateBaja California
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.83
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.85 – -0.23
</td>
<td style="padding:0.2cm; text-align:center; ">
0.89
</td>
<td style="padding:0.2cm; text-align:center; ">
.038
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateBaja California Sur
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
14.22
</td>
<td style="padding:0.2cm; text-align:center; ">
-281.29 – NA
</td>
<td style="padding:0.2cm; text-align:center; ">
1455.40
</td>
<td style="padding:0.2cm; text-align:center; ">
.992
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateCampeche
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-16.67
</td>
<td style="padding:0.2cm; text-align:center; ">
NA – 139.24
</td>
<td style="padding:0.2cm; text-align:center; ">
999.57
</td>
<td style="padding:0.2cm; text-align:center; ">
.987
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateChiapas
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.25
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.49 – -0.37
</td>
<td style="padding:0.2cm; text-align:center; ">
1.02
</td>
<td style="padding:0.2cm; text-align:center; ">
.028
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateChihuahua
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.44
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.39 – 0.07
</td>
<td style="padding:0.2cm; text-align:center; ">
0.84
</td>
<td style="padding:0.2cm; text-align:center; ">
.088
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateCiudad de México
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.79
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.16 – 0.20
</td>
<td style="padding:0.2cm; text-align:center; ">
1.08
</td>
<td style="padding:0.2cm; text-align:center; ">
.097
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateCoahuila de Zaragoza
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.96
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.95 – -0.39
</td>
<td style="padding:0.2cm; text-align:center; ">
0.87
</td>
<td style="padding:0.2cm; text-align:center; ">
.024
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateColima
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-17.03
</td>
<td style="padding:0.2cm; text-align:center; ">
NA – 48.48
</td>
<td style="padding:0.2cm; text-align:center; ">
640.93
</td>
<td style="padding:0.2cm; text-align:center; ">
.979
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateDurango
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.13
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.11 – -0.58
</td>
<td style="padding:0.2cm; text-align:center; ">
0.86
</td>
<td style="padding:0.2cm; text-align:center; ">
.013
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateGuanajuato
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.46
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.57 – 0.28
</td>
<td style="padding:0.2cm; text-align:center; ">
0.95
</td>
<td style="padding:0.2cm; text-align:center; ">
.124
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateGuerrero
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.05
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.02 – 0.48
</td>
<td style="padding:0.2cm; text-align:center; ">
0.85
</td>
<td style="padding:0.2cm; text-align:center; ">
.218
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateHidalgo
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.51
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.80 – 0.46
</td>
<td style="padding:0.2cm; text-align:center; ">
1.06
</td>
<td style="padding:0.2cm; text-align:center; ">
.153
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateJalisco
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.32
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.34 – -0.72
</td>
<td style="padding:0.2cm; text-align:center; ">
0.89
</td>
<td style="padding:0.2cm; text-align:center; ">
.009
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateMéxico
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.84
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.86 – -0.24
</td>
<td style="padding:0.2cm; text-align:center; ">
0.88
</td>
<td style="padding:0.2cm; text-align:center; ">
.037
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateMichoacán de Ocampo
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.31
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.29 – 0.23
</td>
<td style="padding:0.2cm; text-align:center; ">
0.85
</td>
<td style="padding:0.2cm; text-align:center; ">
.124
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateMorelos
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.00
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.09 – 0.73
</td>
<td style="padding:0.2cm; text-align:center; ">
0.94
</td>
<td style="padding:0.2cm; text-align:center; ">
.286
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateNayarit
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.33
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.39 – -0.69
</td>
<td style="padding:0.2cm; text-align:center; ">
0.91
</td>
<td style="padding:0.2cm; text-align:center; ">
.010
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateNuevo León
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.94
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.91 – -0.42
</td>
<td style="padding:0.2cm; text-align:center; ">
0.85
</td>
<td style="padding:0.2cm; text-align:center; ">
.022
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateOaxaca
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.95
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.13 – -0.15
</td>
<td style="padding:0.2cm; text-align:center; ">
0.99
</td>
<td style="padding:0.2cm; text-align:center; ">
.047
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
statePuebla
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.39
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.68 – 1.73
</td>
<td style="padding:0.2cm; text-align:center; ">
1.08
</td>
<td style="padding:0.2cm; text-align:center; ">
.720
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateQuerétaro
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
13.91
</td>
<td style="padding:0.2cm; text-align:center; ">
-281.59 – NA
</td>
<td style="padding:0.2cm; text-align:center; ">
1455.40
</td>
<td style="padding:0.2cm; text-align:center; ">
.992
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateQuintana Roo
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.43
</td>
<td style="padding:0.2cm; text-align:center; ">
-5.79 – 0.09
</td>
<td style="padding:0.2cm; text-align:center; ">
1.41
</td>
<td style="padding:0.2cm; text-align:center; ">
.086
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateSan Luis Potosí
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.47
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.58 – 0.26
</td>
<td style="padding:0.2cm; text-align:center; ">
0.94
</td>
<td style="padding:0.2cm; text-align:center; ">
.120
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateSinaloa
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.03
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.00 – -0.50
</td>
<td style="padding:0.2cm; text-align:center; ">
0.85
</td>
<td style="padding:0.2cm; text-align:center; ">
.017
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateSonora
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.97
</td>
<td style="padding:0.2cm; text-align:center; ">
-5.07 – -1.28
</td>
<td style="padding:0.2cm; text-align:center; ">
0.93
</td>
<td style="padding:0.2cm; text-align:center; ">
.001
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateTabasco
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.43
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.77 – -0.47
</td>
<td style="padding:0.2cm; text-align:center; ">
1.07
</td>
<td style="padding:0.2cm; text-align:center; ">
.023
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateTamaulipas
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.97
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.92 – -0.47
</td>
<td style="padding:0.2cm; text-align:center; ">
0.84
</td>
<td style="padding:0.2cm; text-align:center; ">
.018
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateTlaxcala
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
13.78
</td>
<td style="padding:0.2cm; text-align:center; ">
-281.75 – NA
</td>
<td style="padding:0.2cm; text-align:center; ">
1455.40
</td>
<td style="padding:0.2cm; text-align:center; ">
.992
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateVeracruz de Ignacio de la Llave
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-2.15
</td>
<td style="padding:0.2cm; text-align:center; ">
-4.20 – -0.52
</td>
<td style="padding:0.2cm; text-align:center; ">
0.90
</td>
<td style="padding:0.2cm; text-align:center; ">
.017
</td>
</tr>
<tr>
<td style="font-style:italic; padding:0.2cm; padding-left:0.6cm; text-align:left;">
stateZacatecas
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.01
</td>
<td style="padding:0.2cm; text-align:center; ">
-3.08 – 0.69
</td>
<td style="padding:0.2cm; text-align:center; ">
0.93
</td>
<td style="padding:0.2cm; text-align:center; ">
.277
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbAug
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.01
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.58 – 0.61
</td>
<td style="padding:0.2cm; text-align:center; ">
0.30
</td>
<td style="padding:0.2cm; text-align:center; ">
.977
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbDec
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.07
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.75 – 0.61
</td>
<td style="padding:0.2cm; text-align:center; ">
0.35
</td>
<td style="padding:0.2cm; text-align:center; ">
.845
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbFeb
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.03
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.59 – 0.66
</td>
<td style="padding:0.2cm; text-align:center; ">
0.32
</td>
<td style="padding:0.2cm; text-align:center; ">
.919
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbJan
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.22
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.91 – 0.46
</td>
<td style="padding:0.2cm; text-align:center; ">
0.35
</td>
<td style="padding:0.2cm; text-align:center; ">
.529
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbJul
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.33
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.97 – 0.30
</td>
<td style="padding:0.2cm; text-align:center; ">
0.32
</td>
<td style="padding:0.2cm; text-align:center; ">
.302
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbJun
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.17
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.46 – 0.81
</td>
<td style="padding:0.2cm; text-align:center; ">
0.32
</td>
<td style="padding:0.2cm; text-align:center; ">
.595
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbMar
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.43
</td>
<td style="padding:0.2cm; text-align:center; ">
-1.06 – 0.21
</td>
<td style="padding:0.2cm; text-align:center; ">
0.32
</td>
<td style="padding:0.2cm; text-align:center; ">
.187
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbMay
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.15
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.48 – 0.78
</td>
<td style="padding:0.2cm; text-align:center; ">
0.32
</td>
<td style="padding:0.2cm; text-align:center; ">
.651
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbNov
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.15
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.50 – 0.79
</td>
<td style="padding:0.2cm; text-align:center; ">
0.33
</td>
<td style="padding:0.2cm; text-align:center; ">
.658
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbOct
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.14
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.74 – 0.47
</td>
<td style="padding:0.2cm; text-align:center; ">
0.31
</td>
<td style="padding:0.2cm; text-align:center; ">
.662
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left;">
MonthAbbSep
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; ">
0.30
</td>
<td style="padding:0.2cm; text-align:center; ">
-0.35 – 0.95
</td>
<td style="padding:0.2cm; text-align:center; ">
0.33
</td>
<td style="padding:0.2cm; text-align:center; ">
.364
</td>
</tr>
<tr>
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;">
Observations
</td>
<td style="padding-left:0.5em; padding-right:0.5em; border-top:1px solid;">
 
</td>
<td style="padding:0.2cm; padding-top:0.1cm; padding-bottom:0.1cm; text-align:center; border-top:1px solid;" colspan="4">
1174
</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
R<sup>2</sup> / adj. R<sup>2</sup>
</td>
<td style="padding-left:0.5em; padding-right:0.5em;">
 
</td>
<td style="padding:0.2cm; text-align:center; padding-top:0.1cm; padding-bottom:0.1cm;" colspan="4">
.093 / .128
</td>
</tr>
</table>
    ## [1] 0.4246105

These results indicate that if the government operates with perfect lethality, they reduce the odds of the government incurring a death in an event with conflict by 42% controlling for location and time of year, the effect is statistically significant at the p&lt;.001 level.

This analysis indicates a very significant drop in conflict events with government deaths if the government executes with perfect lethality. Plot 1 indicates that the government incurs a casualty in a much smaller portion of the events where perfect lethality is used. This is a very important relationship to examine and we would highly recommend further study; if perfect lethality prevents government deaths it would partially explain its frequency in these conflicts (the government agencies would have a lot of incentive to act more lethally if it prevents deaths on their side). At the same time, these government run organizations have a civic duty to reduce the number of people killed in raids. This creates an interesting dynamic between two opposing forces; the government agencies that conduct these raids and the government oversight organizations responsible for good governance. The former would probably support using more lethal force if it prevents deaths of their own people, the latter would probably push the agencies to reduce their lethality to prevent human rights abuses. There are limitations to this analysis; the sample is bias towards events with no deaths. This is hard to overcome as the events just occur in this distribution. Overall, this analysis gives valuable insight into a difficult subject and suggests that further study would be beneficial.

![](Question_1_w_graph_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
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
