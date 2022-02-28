# Sql-Data-Exploration
## Background
This is a personal exploratory project done on covid 19 dataset to understand the different aspects of a dataset.Exploratory data analysis is used to summarize the main characteristics of a dataset, to examine data before building model, find patterns, relations and anomalies in data using statistical graphs and other visualization, identify faulty points in data, understand relationship between variables.There is no common method to perfom EDA.

## Objective
My purpose with this project is to source, clean and analyze the covid data as an exploration, constructing and answerring interesting questions along the way.Important insights
are to be communicated in a Tbleau story board.

## The Analysis
The data used in the project can be found on Kaggle.com and the software used were SQL, Tableau, Excel and Word.
Data cleaning performed included Removing duplicates rows. Chaning null values to zero anf fixing discrepancies.
### Steps
1. Source and clean/prep the data,
documenting each step in Word
2. Derive new columns and investigate
subsets of the data using joins 
3. Create a list of questions to explore
4. Answer the research questions using SQL queries and fucntions such as Joins, aggregate functions Common table expressions, Window functions and Temp tables.
5. Create a story board in Tableau with the most interesting insights,answering any remaining research questions using Tableau.

## The Questions
I compiled the following list of questions to explore for this project:

1. What is the Percentage of Total deaths vs Population in Nigeria.
2. What are the Total cases vs Population in Nigeria
3. What Countries have the highest infection rate compared to population.
4. Which Countries have the highest death rate compared to population.
5. Which Continents have the highest death rate compared to population.
6. What are the Global numbers.
7. How many vaccinations for each country.
8. What is the Total population vs vaccinations.

## The Obstacle
There were two tables Covid deaths and Covid Vaccinations which had similar parameters.This was solved by removing the un-necessasry tables which had no bearing on the questions i wanted to ask and i perfomed a join on these two tables to be able to get the data i needed at the time without getting duplicates.

## The Insights
1. In Nigeria, the Death percentage was high in April and May 2020 ranging between 3.0-3.6%. The date with the highest death percentage was May 2nd, 2020 with 3.55%.
2. The population in Nigeria was infected most in March 2020. It maintained a high percent of 9.46 for 8 days from March 9th -16th, 2020.
3. As of early November 2021, Montenegro has 23% of its population infected with COVID-19. It is the highest worldwide, followed by Seychelles at 22%. Micronesia has the lowest with 0.00086% of its population infected with COVID-19.
4. The global number of total Covid-19 cases till 2nd December 2021 is 263,611,718 and the total deaths are 5,217,634 with 1.98% as death percentage.

## The Visuals
![image](https://user-images.githubusercontent.com/80991620/155967427-62ca1225-a67a-41fe-9aa1-e2e5c606ce70.png)

## Recommendations
1. Observe the WHO regulatory rules for minimizing the spread of the virus. 
2. Countries in Europe, Asia, North and North and South America should enforce strict observation of the WHO regulatory rules to reduce the spread of the virus.


