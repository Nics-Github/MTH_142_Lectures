# Code I want to remember. 

library(tidyverse)
library(openintro)

# Bar graphs are for categorical data
ggplot(data = assortive_mating, mapping = aes(x=self_male)) +
  geom_bar()

# Below I am manually filling in the eye color. 

ggplot(data = assortive_mating, mapping = aes(x=self_male, fill=partner_female)) +
  geom_bar()+
  scale_fill_manual(values =c("blue", "brown", "green"))

#----------------

#Numeric Data Graph below. 

library(palmerpenguins)
ggplot(data = penguins, mapping = aes(x = body_mass_g)) +
  geom_histogram()

# Filling a boxplot
ggplot(data = penguins, mapping = aes(x = body_mass_g, fill = species)) +
  geom_boxplot()

#summarize data 
summary(penguins$body_mass_g)

#---------------
# Finding outliers with R

# This is just the five number summary
five_number_pengiuns <-fivenum(penguins$body_mass_g)

# This is the IQR of the penguin's mass
iqr_mass <- IQR(x= penguins$body_mass_g, na.rm = TRUE)

q1 <- five_number_pengiuns[2]
q3 <- five_number_pengiuns[4]

# This is the lower bound
q1 - 1.5*iqr_mass 

# This is the upper bound
q3 + 1.5*iqr_mass

min(penguins$body_mass_g, na.rm = TRUE)
max(penguins$body_mass_g, na.rm = TRUE)
#-----------------
  
# Making a scatter plot

#filter example
babies <- filter(.data = babies, gestation > 259)

ggplot(data=babies, aes(x = gestation, y = bwt)) +
  geom_point()+
  geom_smooth(method = "lm", se=FALSE)

# Find the correlation coef.
summarise(.data = babies, r = cor(gestation,bwt,use="complete.obs"))

#Make a model
library(broom)
babies_lm <-lm(bwt~gestation, data = babies, method = "complete.obs")
tidy(babies_lm)

# Normal distribution
## find percentiles

pnorm(q=85.8 ,m = 92.6, s = 3.6)

# Finding the complement of the percentile. 
pnorm(q=85.8 ,m = 92.6, s = 3.6, lower.tail = FALSE)

# Find a quantile from a percentile
qnorm(p = 0.02945336, m = 92.6, s = 3.6)


# CI framework

library(openintro)


## New yorker Quarantine problem


phat = 0.82
n = 1042
SE = sqrt(0.82*(1-0.82)/n)
zscore = qnorm(p = 0.0015, lower.tail = FALSE)

# Make Confidence interval
phat - zscore * SE
phat + zscore * SE

# Simulation 

# Make p-hat

# This makes a 60% success sample. 

major_sample <-   c(rep("yes", 15), rep("no", 10))

# This saves the sample as a dataframe
major_sample <- as.data.frame(major_sample)

# This changed the name of the variable to "has_disease"
names(major_sample) <-"work"

# There is no simulation happening here. Notice the pipes.
# We are saving p_hat for later... It might be easier to type
# p_hat <- 15/25
p_hat <- major_sample  |>
  
  # specify which variable you are interested in, and which level is a success (our level is "yes")
  specify(response = work, success = "yes") |>
  
  # What is the statsitic we want calculated?
  calculate(stat = "prop")


## Create parametric distribution w/ infer()

set.seed(2018)


null_distn_one_prop <- major_sample |>
  
  specify(response = work, success = "yes") |>
  
  hypothesize(null = "point", p = 0.70) |>
  
  generate(reps = 10000 , type = "draw") |>
  
  calculate(stat = "prop")


## Add the p-value to graph


visualize(null_distn_one_prop) +
  shade_p_value(obs_stat = p_hat, direction = "less")


## `get_pvalue()`

pvalue <- null_distn_one_prop %>%
  get_pvalue(obs_stat = p_hat, direction = "less")
pvalue


## CI for difference of proportions

p_1 = 0.22
p_2 = 0.35
p_2-p_1
SE = sqrt(p_1*(1-p_1)/50+p_2*(1-p_2)/40)
SE
  
## The 95% CI
Z = 1.96

# "Lower Bound"
p_2-p_1 - Z* SE

# "Upper Bound"
p_2-p_1 + Z* SE

## Hypothesis test two proportions 

p_pool = 25/90
SE = sqrt(p_pool*(1-p_pool)*(1/50+1/40))
SE

# pvalue (multiply by 2, if two tailed test)
2*pnorm(q = 0.13, mean = 0, sd = SE, lower.tail = FALSE)

### Hypothesis testing for a single mean
x_bar = 14600
mu = 18000
s_x = 7765.31
n = 5

# test statistic
test_stat = (x_bar - mu)/(s_x/sqrt(n))

# Find pvalue for two tailed test. 
2*pt(q=test_stat, df=4)

# ANOVA 
results <- aov(value~groups, data = pivoted_problem_3)
results
