#Group Members: Mohammed A.Al Muhaymin, Luis Melo

load("~/Downloads/111111111 ECO B2000/Household_Pulse_data_w57.RData")
install.packages("tidyverse")
restrict1 <- (Household_Pulse_data$RECVDVACC  == "yes got vaxx") | (Household_Pulse_data$RECVDVACC == "no did not get vaxx")
VACVIEW <- subset(Household_Pulse_data,restrict1)

YES_LESS_HS <- sum((VACVIEW$EEDUC == "less than hs") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#297 of people with less than high school education got vaccinated
#The probability of students with less than high school education getting vaccinated is 0.689

NO_LESS_HS <- sum((VACVIEW$EEDUC == "less than hs") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#134 of people with less than high school education did not vaccinated
#The probability of students with less than high school education not vaccinated is 0.310

YES_SOME_HS <- sum((VACVIEW$EEDUC == "some hs") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#645 of people with some high high school education got vaccinated
#The probability of students with some high school education getting vaccinated is 0.717

NO_SOME_HS <- sum((VACVIEW$EEDUC == "some hs") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#254 of people with some high school education did not vaccinated
#The probability of students with some high school education not vaccinated is 0.149

YES_HS_DIPLOMA <- sum((VACVIEW$EEDUC == "HS diploma") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#5631 of people with high school diploma got vaccinated
#The probability of students with high school diploma education and getting vaccinated is 0.755

NO_HS_DIPLOMA <- sum((VACVIEW$EEDUC == "HS diploma") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#1828 of people with hisch school doploma did not get vaccinated
#The probability of students with high school education and not vaccinated is 0.324


YES_SOME_COLL <- sum((VACVIEW$EEDUC == "some coll") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#10160 of people with some college education got vaccinated
#The probability of students with some college degree education and getting vaccinated is 0.815

NO_SOME_COLL <- sum((VACVIEW$EEDUC == "some coll") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#2305 of people with some college education did and not got vaccinated
#The probability of students with some college degree education and not getting vaccinated is 0.185

YES_ASSOC_DEG <- sum((VACVIEW$EEDUC == "assoc deg") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#4989 of people with associate degree education got vaccinated
#The probability of students with associate degree education and getting vaccinated is 0.827


NO_ASSOC_DEG <- sum((VACVIEW$EEDUC == "assoc deg") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#1044 of people with associate degree education did not vaccinated
#The probability of students with associate degree education and not getting vaccinated is 0.173

YES_BACH_DEG <- sum((VACVIEW$EEDUC == "bach deg") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#15072 of people with bachelor degree education got vaccinated
#The probability of students with bachelor degree education and getting vaccinated is 0.913

NO_BACH_DEG <- sum((VACVIEW$EEDUC == "bach deg") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#1437 of people with bachelor degree education did not get vaccinated
#The probability of students with bachelor degree education and not getting vaccinated is 0.087


YES_ADV_DEG <- sum((VACVIEW$EEDUC == "adv deg") & (VACVIEW$RECVDVACC == "yes got vaxx"))
#14209 of people with advanced degree education got vaccinated
#The probability of students with advanced degree education and getting vaccinated is 0.958

NO_ADV_DEG <- sum((VACVIEW$EEDUC == "adv deg") & (VACVIEW$RECVDVACC == "no did not get vaxx"))
#628 of people with advanced degree education did not vaccinated
#The probability of students with advanced education and not getting vaccinated is 0.042


#Some interesting thing I found:
#The probabilities are mutually exclusive because and you can not be vaccinated and not vaccinated at the some time
#Also, one can not be in high school and advanced degree at the same time
#The probabilities are exhaustive because the probability of education and 
#not getting vaccinated and the probability of education and getting vaccinated is equal to 1.
#There is a positive correlation with education and vaccination
#More people with higher education got vaccinated than not vaccinated
#It is more likely than you are vaccinated than not vaccinated with higher education
#There could be other factors that impacted as well such as income and age
