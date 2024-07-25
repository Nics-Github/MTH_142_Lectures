plot(-6:5,0:11, col = "white")

library(openintro)
normTail()
my_phat <- c(0.45,0.55)
abline(v=0.5)  
for(i in 1:10){
  n=30
  x = my_phat[i]
  se = sqrt(x*(1-x)/n)
  l = x - 2*se
  u = x + 2*se
  lines( )
}
legend("topleft", legend = c("base r","is cool"), col = c("black","blue"), pch = c(0,1))

plot(1)
dev.off()


plot(-6:5,0:11, col = "white")

# Making CI from some sample proportions.
library(tidyverse)
my_phat = c(0.45,0.55,0.49)
df<-data.frame(start=1,end = 1,y = 1)

# Loop through to find each lower and upper bound

for(i in 1:length(my_phat)){
  # sample size
  n=30
  
  # x is a given p-hat
  x = my_phat[i]
  
  # calculate the se
  se = sqrt(x*(1-x)/n)
  
  # calculate the lower bound of CI
  l = x - 2*se
  
  # calculate the upper bound of CI
  u = x + 2*se
  
  # Add to df. 
  df[i,] = c(start = l, end=u , y = i/10)
  df
  
}

ggplot(data = df, group = y)+
  geom_segment(aes(x=start, xend = end, y = y, yend=y ))+
  geom_vline(xintercept = 0.5)

# Making CI from some sample proportions.
# Ben's solution

library(tidyverse)

p <- 0.3
n <- 30

sims <- tibble(
  p_hat = rbinom(n = 100, size = n, prob = p) / n,
  se = sqrt(p_hat * (1 - p_hat) / n),
  lower = p_hat - 2 * se,
  upper = p_hat + 2 * se,
  covers = lower <= p & upper >= p
) |>
  mutate(id = row_number())

ggplot(data = sims) +
  geom_vline(xintercept = p, linetype = 3) +
  geom_segment(aes(x = lower, xend = upper, y = id, yend = id, color = covers)) +
  annotate("text", x = p, y = 105, label = paste("Coverage rate:", sum(sims$covers) / nrow(sims)))
