---
  title: "Final Project check in 1"
author: "Thrishul Pola"
description: "Final Project Check in 1"
date: "3/22/2023"
format:
  html:
  df-print: paged
css: styles.css
toc: true
code-fold: true
code-copy: true
code-tools: true
categories:
  - Final_Project_Checkin_1
---
  
  ```{r}
library(tidyverse)
library(ggplot2)
library(readr)
library(sqldf)
library(data.table)

```{r}

```
## Research Question

The World happiness data tries to measure the happiness of the populace of every country and comes up with a score which connotes the level of happiness of the populace.

The data set uses various variables to measure happiness such as the GDP per capita, Freedom to make choices, life expectancy, the perception of corruption, generosity and social support.

In this study, I aim to find out answers to the following research questions:
  
1.  What are the variables or factors that are affecting world's happiness, with a focus on individual countries & continents. This includes analyzing the correlation between most effective variables.
2.  To find out which model accurately predicts the happiness score.


## Hypothesis

I wish to test the following hypothesis,

1.  Better economy of a country would lead to happiness
2.  Longer life expectancy would lead to happiness
3.  Having family/social support leads to happiness
4.  Freedom leads to happiness
5.  People's trust in the Government leads to happiness
6.  Generosity leads to happiness

## Model

Look at each variable individually, and put all the variables together.

## Data Preparation

### Reading the data set
```{r}
primary <- read.csv("project datasets/2022.csv")
head(primary)
str(primary)
str(primary$Country)
```

The dataset that I have chosen is happiness 2022 dataset, one of Kaggle's dataset. This dataset gives the happiness rank and happiness score of 147 countries around the world based on 8 factors including GDP per capita, Social support, Health life expectancy, freedom to make life choices, Generosity, Perceptions of corruption and dystopia residual. The higher value of each of these 8 factors means the level of happiness is higher. Dystopia is the opposite of utopia and has the lowest happiness level. Dystopia will be considered as a reference for other countries to show how far they are from being the poorest country regarding happiness level.

Source of the data: World Happiness Report 2022 use data from the Gallup World Poll surveys from 2019 to 2021. They are based on answers to the main life evaluation question asked in the poll.

Some of the variable names are not clear enough and I decided to change the name of several of them a little bit. Also, I will remove whisker low and whisker high variables from my dataset because these variables give only the lower and upper confidence interval of happiness score and there is no need to use them for visualization and prediction.

The next step is adding another column to the dataset which is continent. I want to work on different continents to discover whether there are different trends for them regarding which factors play a significant role in gaining higher happiness score. Asia, Africa, North America, South America, Europe, and Australia are our six continents in this dataset. Then I moved the position of the continent column to the second column because I think with this position arrange, dataset looks better. Finally, I changed the type of continent variable to factor to be able to work with it easily for visualization.

## Preparation of the data

```{r}
# Changing the name of columns
colnames (primary) <- c("Country", "Happiness.Rank", "Happiness.Score",
                          "Whisker.High", "Whisker.Low", "Economy", "Family",
                          "Life.Expectancy", "Freedom", "Generosity",
                          "Trust", "Dystopia.Residual")

# Country: Name of countries
# Happiness.Rank: Rank of the country based on the Happiness Score
# Happiness.Score: Happiness measurement on a scale of 0 to 10
# Whisker.High: Upper confidence interval of happiness score
# Whisker.Low: Lower confidence interval of happiness score
# Economy: The value of all final goods and services produced within a nation in a given year
# Family: Importance of having a family
# Life.Expectancy: Importance of health and amount of time prople expect to live
# Freedom: Importance of freedom in each country
# Generosity: The quality of being kind and generous
# Trust: Perception of corruption in a government
# Dystopia.Residual: Plays as a reference

# Deleting unnecessary columns (Whisker.high and Whisker.low)

primary <- primary[, -c(4,5)]
```

```{r}
primary$Continent <- NA

primary$Continent[which(primary$Country %in% c("Israel", "United Arab Emirates", "Singapore", "Thailand", "Taiwan Province of China",
                                   "Qatar", "Saudi Arabia", "Kuwait", "Bahrain", "Malaysia", "Uzbekistan", "Japan",
                                   "South Korea", "Turkmenistan", "Kazakhstan", "Turkey", "Hong Kong S.A.R., China", "Philippines",
                                   "Jordan", "China", "Pakistan", "Indonesia", "Azerbaijan", "Lebanon", "Vietnam",
                                   "Tajikistan", "Bhutan", "Kyrgyzstan", "Nepal", "Mongolia", "Palestinian Territories",
                                   "Iran", "Bangladesh", "Myanmar", "Iraq", "Sri Lanka", "Armenia", "India", "Georgia",
                                   "Cambodia", "Afghanistan", "Yemen", "Syria"))] <- "Asia"
primary$Continent[which(primary$Country %in% c("Norway", "Denmark", "Iceland", "Switzerland", "Finland",
                                   "Netherlands", "Sweden", "Austria", "Ireland", "Germany",
                                   "Belgium", "Luxembourg", "United Kingdom", "Czech Republic",
                                   "Malta", "France", "Spain", "Slovakia", "Poland", "Italy",
                                   "Russia", "Lithuania", "Latvia", "Moldova", "Romania",
                                   "Slovenia", "North Cyprus", "Cyprus", "Estonia", "Belarus",
                                   "Serbia", "Hungary", "Croatia", "Kosovo", "Montenegro",
                                   "Greece", "Portugal", "Bosnia and Herzegovina", "Macedonia",
                                   "Bulgaria", "Albania", "Ukraine"))] <- "Europe"
primary$Continent[which(primary$Country %in% c("Canada", "Costa Rica", "United States", "Mexico",  
                                   "Panama","Trinidad and Tobago", "El Salvador", "Belize", "Guatemala",
                                   "Jamaica", "Nicaragua", "Dominican Republic", "Honduras",
                                   "Haiti"))] <- "North America"
primary$Continent[which(primary$Country %in% c("Chile", "Brazil", "Argentina", "Uruguay",
                                   "Colombia", "Ecuador", "Bolivia", "Peru",
                                   "Paraguay", "Venezuela"))] <- "South America"
primary$Continent[which(primary$Country %in% c("New Zealand", "Australia"))] <- "Australia"
primary$Continent[which(is.na(primary$Continent))] <- "Africa"

view(primary)

# Moving the continent column's position in the dataset to the second column

primary <- primary %>% select(Country,Continent, everything())

#Renaming the final dataframe to happy

happy <- primary
str(happy)
```


