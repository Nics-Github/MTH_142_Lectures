---
title: "Numeric Data"
subtitle: "Most of this is stolen from Ben Baumer"
author: "Schwab?"
format: 
  revealjs: 
    theme: beige
  html:  
    code-overflow: scroll
editor: visual
execute: 
  echo: true
---

## Read before lecture

[Chapter 5 Numeric Data](https://openintro-ims.netlify.app/explore-numerical)

## Summarizing distributions

Numeric Data

::: incremental
-   Shape, Center, and Spread
:::

## Load the libraries

```{r}
library(tidyverse)
library(palmerpenguins)
```

## Histogram

Summarize the **shape** of the distribution of one variable

```{r}
ggplot(data = penguins, mapping = aes(x = body_mass_g)) +
  geom_histogram()
```

## Density plot

Summarize the **shape** of the distribution of one variable

```{r}
#| code-line-numbers: "2"
ggplot(data = penguins, mapping = aes(x = body_mass_g)) +
  geom_density()
```

## Box plot

Summarize the **shape** of the distribution of one variable

```{r}
#| code-line-numbers: "2"
ggplot(data = penguins, mapping = aes(x = body_mass_g)) +
  geom_boxplot()
```

## Your turn

-   Use a data graphic to summarize the distribution of the `height` variable in the `starwars` data frame.

## Histogram: two variables

```{r}
#| code-line-numbers: "1|2"
ggplot(data = penguins, mapping = aes(x = body_mass_g, fill = species)) +
  geom_histogram()
```

## Density plot: two variables

```{r}
#| code-line-numbers: "2"
ggplot(data = penguins, mapping = aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.4)
```

## Boxplot: two variables

```{r}
#| code-line-numbers: "2"
ggplot(data = penguins, mapping = aes(x = body_mass_g, fill = species)) +
  geom_boxplot()
```

## Measures of center

::: incremental
-   mean: `mean()`
-   median: `median()`
:::

```{r}
#| code-line-numbers: "1|2|3|4|5"

# When using summarize functions like n() and mean() the words to the left of the = are the column headers.

  summarize(
    .data = penguins,
    number_of_penguins = n(),
    mean_mass = mean(body_mass_g, na.rm = TRUE),
    median_mass = median(body_mass_g, na.rm = TRUE)
  )
```

## Measures of spread

::: incremental
-   standard deviation: `sd()`
-   variance: `var()`
-   range: `range()`
-   IQR: `IQR()`
:::

```{r}
#| code-line-numbers: "1|2|3|4|5"

  summarize(
    .data = penguins,
    number_of_penguins = n(),
    sd_mass = sd(body_mass_g, na.rm = TRUE),
    var_mass = var(body_mass_g, na.rm = TRUE)
  )
```

## Quantiles

Most summary information can be found with the `fivnum()` or `summary()` function.

```{r}

# This is just the five number summary
five_number_pengiuns <-fivenum(penguins$body_mass_g)
five_number_pengiuns

#This is the five number plus summary
summary(penguins$body_mass_g)

```

```{r}
# This is how you can get the exact quantile. 
quantile(x= penguins$body_mass_g, probs = c(0.25,0.5), na.rm=TRUE)
```

## Graphed Quantiles

```{r}
# Note the vertical line showing the 25th percentile. 
ggplot(data = penguins, aes(x = body_mass_g)) +
  geom_density()+
  geom_vline(xintercept = 3550, color = "purple") 
```

## Your turn

-   Summarize the distribution of the `height` variable in the `starwars` data frame by computing:
    -   the number of observations
    -   the mean
    -   the standard deviation
-   Find the 80th quantile for the `height` variable in the `starwars` data.

## Answer here. 

## Outliers

Along a number line to locate outliers we first calculate the two bounds\

$$
L = Q1 - 1.5 \times IQR \\
U = Q3 + 1.5 \times IQR 
$$

Any values outside that range are considered outliers.

Let's do this with penguins mass.

## Calculate outlier bounds in R

```{r}
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
```

## Your turn

-   Make a boxplot of mass of the starwars characters

-   Calculate the outlier range (by hand or in the computer).

-   Who are the outliers?

## Answer here
