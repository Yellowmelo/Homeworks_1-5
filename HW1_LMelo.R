load("~/Downloads/Household_Pulse_W57/Household_Pulse_data_w57.RData")
view(Household_Pulse_data)
summary(Household_Pulse_data)
dim(Household_Pulse_data)
library(tidyverse)
ggplot(data = Household_Pulse_data) + 
  geom_point(mapping = aes(x = RENTCUR, y = MORTCUR, color = INCOME))

