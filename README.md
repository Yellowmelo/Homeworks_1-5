# HW2_LMelo

### Lab1 

## Group Members, Muhibul 


# PP1 
  The initial roll was not a 6, therefor we concluded the die was fair
  
  The die being unfair has probability P(6) = 1/6 or 16.67% 
  
  Initially thinking the probability of a fair die was 1-P(6) , however with hindsight the Probability of the die being fair depends on how one judges the die

# PP2
  In my trial the data was, Roll 20 <- data.set(2,	5,	2,	4,	2,	4,	3,	3,	5,	5,	4,	4,	6,	4,	1,	3,	2,	5,	6,	6,
    
  Findings were that P(6) occured 3 times
  Decision ruling is if P(6) occurs > 3 times, the die is unfair
  
  Considering the stats question if fair dice are rolled 20 times, what is likely number of 6 resulting? 
    Given that fair die P(6) = 1/6 , then after 20 tries , Probability is 1/6*20 or 3.33
  
  When 1 more or less rolls are added we do not see a significant change notating the die to be unusual, same net probability for +/- proposing the rolls following the Law of Large Numbers or diminishing margins of return


# PP3
  Decision ruling is if P(6) occurred => 20 then the die is unfair
  
  In simulating 100 rolls R provided the below data with results of P(6) occuring 19 times, therefor die is fair
     
      #how_many_rolls <- 100
      sim_rolls <- sample(1:6, how_many_rolls, replace = TRUE)
      sum(sim_rolls == "6")
      #[1]19
  
  In analyzing, it is fair to say that there is some confidence level atached to this and any conclusion depending on the observer. Boundaries would be subjective to the observers sensitivity to the data. 
  
  With that, the view of the die being fair or unfair is also subjective to the results of the specific sample despite stattistical analysis. I
  In our dataset, with desicion ruling of Fair = P(6) up 19, the chance of the die being unfair is 80/6 or 13.33

# EP1

  We did a simulated roll of a vector with 100 rows and 50 columns for 5,000 rolls
  
  Decision rule if P(6) occurs > 25% of the time then the die is unfair
  
  our results below showed an occurence of 843 times or 16.86% showing the die to be fair
   
    #> if_come_up_6 <- (lots_of_sim_rolls == 6)
    #> sum(if_come_up_6)
    #[1] 843
    #> mean(if_come_up_6)
    #[1] 0.1686
 
  To note, it is interesting that within our dataset the probability of 6 showed up closer to the original statistical probability of 6 on a fair die or 16.67%. I suppose this is driving home the point of the law of large numbers.
  
  I would have greater confidence in my conclusion if a distribution table of the other results would show a similar probobaility statistic
  
  I would modify the analysis of only looking at a single number of die result and compare to the range of the other numbers
