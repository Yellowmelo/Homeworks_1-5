# HW_4_LMelo
#####################################################################
#                         Lab 3                                     #
# Luis Melo                                                         #
#           Other Group Members; Mishal & Mohammed                  #
#####################################################################


load("~/Desktop/ecob2000_Econometrics/Household_Pulse_data_w57.RData")
require(tidyverse)
require(class)
require(caret)
summary(Household_Pulse_data$KIDGETVAC_5_11Y)
# We are looking to create a hypothesis based on data for kids age 5-11 years old and their vaccination status
# We start by removing the problematic "NA" part of the 
dat_kidvaxx_nonmissing <- subset(Household_Pulse_data, (Household_Pulse_data$KIDGETVAC_5_11Y != "NA") )
# Looks to have gone right, data for subset is generated
# Below will summarize the data subset of kids 5-11 yo, Feel Free to skip
summary(dat_kidvaxx_nonmissing)
# We will now assign a rank value to the data set responses of 5 valuing the Vaccine most and 1 valuing the vaccine least with the unsures set to the middle at 3 
temp1 <- fct_recode(dat_kidvaxx_nonmissing$KIDGETVAC_5_11Y, '5' = 'kids 5-11yo definitely get vaxx',
                    '4'='kids 5-11yo probably get vaxx', '3'='unsure kids 5-11 get vaxx',
                    '2'='kids 5-11yo probably NOT get vaxx', '1'='kids 5-11yo definitely NOT get vaxx',
                    '3'='do not know plans for vaxx for kids 5-11yo')
summary(temp1)
# Data shows a skew to left with majority of data points scoring 1 for not getting vaxed

# Numeric Factor Conversion, with a scary note NA about the NAs influencing data, however below shows there were no NA data points with 5-11 yo
kidsvax511 <- as.numeric(levels(temp1))[temp1]
summary(kidsvax511)
# Data leans towards most kids 5-11 not having recieved vaccines shown by mean of 1.794 or even with rounding up to nearest category was probably not getting Vaxxed

norm_varb <- function(X_in) {
  (X_in - min(X_in, na.rm = TRUE))/( max(X_in, na.rm = TRUE) - min(X_in, na.rm = TRUE)  )
}

# Lazy Way aka scaredy cat way aka safe way taught by professor
# Attempting to view cross section of Persons who received vaccines and their region

### We are expecting to find that there will be closeness in the relationship between persons who had their kids vaccinated and coastal regions versus northwest and southern regions

data_use_prelim <- data.frame(norm_varb(as.numeric(dat_kidvaxx_nonmissing$RECVDVACC)),norm_varb(as.numeric(dat_kidvaxx_nonmissing$REGION)))

good_obs_data_use <- complete.cases(data_use_prelim,dat_kidvaxx_nonmissing$KIDGETVAC_5_11Y)
dat_use <- subset(data_use_prelim,good_obs_data_use)
y_use <- subset(kidsvax511,good_obs_data_use)

# Algorithm training starts

set.seed(12345)
NN_obs <- sum(good_obs_data_use == 1)
select1 <- (runif(NN_obs) < 0.8)
train_data <- subset(dat_use,select1)
test_data <- subset(dat_use,(!select1))
cl_data <- y_use[select1]
true_data <- y_use[!select1]
summary(cl_data)
summary(train_data)

for (indx in seq(1, 9, by= 2)) {
  pred_y <- knn3Train(train_data, test_data, cl_data, k = indx, l = 0, prob = FALSE, use.all = TRUE)
  num_correct_labels <- sum(pred_y == true_data)
  correct_rate <- num_correct_labels/length(true_data)
  print(c(indx,correct_rate))
}

# regression modeling start

cl_data_n <- as.numeric(cl_data)
summary(as.factor(cl_data_n))
names(train_data) <- c("norm_recvdvax","norm_region")

model_olsv1 <- lm(cl_data_n ~ train_data$norm_recvdvax + train_data$norm_region)

y_hat <- fitted.values(model_olsv1)

# This model shows that with increasing neighbors, there is an increase in their closeness
mean(y_hat[cl_data_n == 2])
mean(y_hat[cl_data_n == 3])
mean(y_hat[cl_data_n == 4])
mean(y_hat[cl_data_n == 5])

model_olsv1

cl_data_n2 <- as.numeric(cl_data_n == 2) 

model_ols_v2 <- lm(cl_data_n2 ~ train_data$norm_recvdvax + train_data$norm_region)
y_hat_v2 <- fitted.values(model_ols_v2)

# This model gives different coefficient values with similar relationship
mean(y_hat_v2[cl_data_n2 == 1])
mean(y_hat_v2[cl_data_n2 == 0])

model_ols_v2

# All in all with both models, the coefficients show that there is no significant correlation between persons recieiving vaccines and their region compared to their kids age 5-11 receiving a vaccine.
# This is proven by having both models showing T values < 1 and P values > .05
# Additionally, perhaps it is easier to choose data without interfering values such as NA or categories where the need to turn qualatative data into quantatitive data is removed
