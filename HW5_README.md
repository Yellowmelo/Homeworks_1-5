Lab_4
================

Luis Melo, Vanessa, Mishal

## Regression Modeling by Wages

For this lab we will be looking into people at prime age in the labor
force who work fulltime, year round according to NYs ACS data from 2017.
We will call this subset “data_use”

``` r
load("~/Desktop/ecob2000_Econometrics/acs2017_ny_data.RData")
 
use_var <- (acs2017_ny$AGE >= 25) & (acs2017_ny$AGE <= 55) & (acs2017_ny$LABFORCE == 2) & (acs2017_ny$WKSWORK2 > 4) & (acs2017_ny$UHRSWORK >= 35)
data_use <- subset(acs2017_ny,use_var) 
```

We then model this subset into a Linear regression of Income Wage
against Age with additional arguments of race and education

``` r
model_temp1 <- lm(INCWAGE ~ AGE + AfAm + Asian + Amindian + race_oth + Hispanic + educ_hs + educ_somecoll + educ_college + educ_advdeg, data = data_use)

require(stargazer)
```

    ## Loading required package: stargazer

    ## 
    ## Please cite as:

    ##  Hlavac, Marek (2022). stargazer: Well-Formatted Regression and Summary Statistics Tables.

    ##  R package version 5.2.3. https://CRAN.R-project.org/package=stargazer

``` r
stargazer(model_temp1, type = "text")
```

    ## 
    ## ===============================================
    ##                         Dependent variable:    
    ##                     ---------------------------
    ##                               INCWAGE          
    ## -----------------------------------------------
    ## AGE                        1,309.133***        
    ##                              (40.163)          
    ##                                                
    ## AfAm                      -15,172.130***       
    ##                             (1,140.767)        
    ##                                                
    ## Asian                         774.020          
    ##                             (1,387.175)        
    ##                                                
    ## Amindian                    -9,586.509         
    ##                             (6,154.668)        
    ##                                                
    ## race_oth                   -7,862.011***       
    ##                             (1,288.568)        
    ##                                                
    ## Hispanic                   -5,168.732***       
    ##                             (1,198.144)        
    ##                                                
    ## educ_hs                    9,418.920***        
    ##                             (1,837.378)        
    ##                                                
    ## educ_somecoll              18,941.360***       
    ##                             (1,878.388)        
    ##                                                
    ## educ_college               53,159.010***       
    ##                             (1,850.468)        
    ##                                                
    ## educ_advdeg                76,904.700***       
    ##                             (1,894.694)        
    ##                                                
    ## Constant                  -14,171.300***       
    ##                             (2,469.049)        
    ##                                                
    ## -----------------------------------------------
    ## Observations                  46,971           
    ## R2                             0.128           
    ## Adjusted R2                    0.128           
    ## Residual Std. Error   77,728.370 (df = 46960)  
    ## F Statistic         691.440*** (df = 10; 46960)
    ## ===============================================
    ## Note:               *p<0.1; **p<0.05; ***p<0.01

The above shows that almost all races have a significant relationship to
income as age increases. With all races but Asian’s having a negative
correlation However, income is showing to increase significantly as the
level of education increases

Below we are now creating a random subset of the data in Income and
selecting 10% of these observations. It will create a cleaner
visualization when plotted.

We are creating a scatter plot with a jitter affect of 1 to give “noise”
to the income values at each age so we can see less overlapping of data
values.

There were also a set of outliers with significantly high income that is
off the charts, we therefor have set a limit of 150k to our plot.

``` r
require(AER)
```

    ## Loading required package: AER

    ## Loading required package: car

    ## Loading required package: carData

    ## Loading required package: lmtest

    ## Loading required package: zoo

    ## 
    ## Attaching package: 'zoo'

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

    ## Loading required package: sandwich

    ## Loading required package: survival

``` r
NNobs <- length(data_use$INCWAGE)
set.seed(12345) 
graph_obs <- (runif(NNobs) < 0.1) 
dat_graph <-subset(data_use,graph_obs)  

plot(INCWAGE ~ jitter(AGE, factor = 1), pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.2), ylim = c(0,150000), data = dat_graph)
title(main = "Income Salary by Age", col.main = "blue")


to_be_predicted2 <- data.frame(AGE = 25:55, AfAm = 0, Asian = 0, Amindian = 1, race_oth = 1, Hispanic = 1, educ_hs = 0, educ_somecoll = 0, educ_college = 1, educ_advdeg = 0)

to_be_predicted2$yhat <- predict(model_temp1, newdata = to_be_predicted2)

lines(yhat ~ AGE, data = to_be_predicted2)
```

![](Lab4_LMelo_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

In Scatter plot “Income Salary by Age” we proceeded to create predicted
values of Income based on age and certain races such as Amindian = 1,
race_oth = 1, Hispanic = 1 as well as educ_college = 1 to create a line
called Yhat This line shows that the values of income range between
about 49099 and 88373, shown by the min and max of the below summary

``` r
summary(to_be_predicted2$yhat)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   49099   58917   68736   68736   78554   88373
