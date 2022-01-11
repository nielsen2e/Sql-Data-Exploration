/* 

Covid 19 Data Exploration

Skills used: Joins, Aggregate Functions, Converting/Casting data types, CTE's, Window Functions, Temp Tables, Creating Views

*/

-- This query displays the CovidDeath Table

SELECT *
FROM CovidDeaths
WHERE continent is not null
ORDER BY 3,4



-- This query displays the CovidVaccinations Table

SELECT *
FROM CovidVaccinations
ORDER BY 3,4



-- This shows the columns we are working with

SELECT location,
       date,
       total_cases,
       new_cases,
       total_deaths,
       population
FROM CovidDeaths
ORDER BY 1,2
total deaths started ramping up amonth after the initial case was found.



-- Lets look at the Percentage of Total Deaths vs Total Cases in Nigeria

SELECT location,
	   date,
	   total_cases,
	   total_deaths, 
	   (total_deaths/total_cases)* 100 as death_percentage
FROM CovidDeaths
WHERE location in ('Nigeria') and continent is not null
ORDER BY 1,2



-- Lets look at the Percentage of Total Cases vs Population in Nigeria

SELECT location,
       date,
	   total_cases,
	   population, 
	   (total_cases/population)*100 as covid_percentage_per_population
FROM CovidDeaths
WHERE location in ('Nigeria')
ORDER BY total_cases 



-- Lets look at Countries with the Highest Infection Rate compared to Population

SELECT location,
       population,
	   MAX(total_cases) as highest_infection_count,
	   MAX((total_cases/population))* 100 as percentage_infected_population
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY percentage_infected_population desc



-- Lets look at Countires with the Highest Death Rate compared to Population

SELECT location,
       population, 
	   MAX(cast(total_deaths as int)) as highest_death_rate,
	   MAX((total_deaths/population)) *100 as percentage_death_population
FROM CovidDeaths
--WHERE continent is not null
GROUP BY location, population
ORDER BY highest_death_rate desc



-- Lets take a look at the CONTINENTS

-- Lets look at Continents with the Highest Death Rate compared to Population

SELECT continent,
       MAX(cast(total_deaths as int)) as highest_death_rate
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY highest_death_rate desc



-- An Alternative way to look at it

SELECT location,
       MAX(cast(total_deaths as int)) as highest_death_rate
FROM CovidDeaths
WHERE continent is  null
GROUP BY location
ORDER BY highest_death_rate desc



--LETS LOOK AT GLOBAL NUMBERS

SELECT date,
       SUM(new_cases) as total_cases, 
	   SUM(cast(new_deaths as int)) as total_deaths, 
	   SUM(cast(new_deaths as int))/SUM(New_cases) * 100 as death_percentage
FROM CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2



--WITHOUT LOOKING AT THE DATES

SELECT  SUM(new_cases) as total_cases,
        SUM(cast(new_deaths as int)) as total_deaths, 
		SUM(cast(new_deaths as int))/SUM(New_cases) * 100 as death_percentage
FROM CovidDeaths
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2



-- Lets look at the Vaccinations Table(An Inner Join was performed)

SELECT dea.continent, 
       dea.location, 
	   dea.date, 
	   dea.population, 
	   vac.new_vaccinations
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 1,2



-- LETS LOOK AT THE TOTAL VACCINATIONS FOR EACH COUNTRY

SELECT dea.location,
       SUM(cast(vac.new_vaccinations as int)) as total_vac
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
GROUP BY dea.location
ORDER BY dea.location



-- Lets look at the Total Population vs Vaccinations

SELECT dea.continent, 
       dea.location,
       dea.date,
       dea.population,
       vac.new_vaccinations,
       SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY 
	   dea.location, dea.date) as rolling_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 1,2



-- Lets use a CTE to perform Calculation on Partition By in previous query

WITH POP_VAC as
(SELECT dea.continent, 
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations,
        SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY 
	    dea.location, dea.date) as rolling_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 1,2
)
SELECT continent,
       location,
	   date,
	   population,
	   new_vaccinations,
	   rolling_vaccinated,
	  (rolling_vaccinated/population) *100
FROM POP_VAC


        
-- Lets use a Temp Table to perform Calculation On Partition By in previous query

DROP TABLE IF EXISTS #Percent_population_vaccinated
CREATE TABLE #Percent_population_vaccinated(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling_vaccinated numeric
)

INSERT INTO #Percent_population_vaccinated
SELECT dea.continent, 
       dea.location,
       dea.date,
       dea.population,
       vac.new_vaccinations,
       SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY 
	   dea.location, dea.date) as rolling_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

SELECT continent,
       location,
	   date,
	   population,
	   new_vaccinations,
	   rolling_vaccinated,
	  (rolling_vaccinated/population) *100
FROM #Percent_population_vaccinated




--Creating  views to store data for later visualizations

CREATE VIEW Percent_population_vaccinated as
SELECT dea.continent, 
       dea.location,
       dea.date,
       dea.population,
       vac.new_vaccinations,
       SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY 
	   dea.location, dea.date) as rolling_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3


CREATE VIEW Percentage_Death as
SELECT location,
	   date,
	   total_cases,
	   total_deaths, 
	   (total_deaths/total_cases)* 100 as death_percentage
FROM CovidDeaths 
WHERE location in ('Nigeria') and continent is not null
--ORDER BY 1,2


CREATE VIEW Percentage_Per_Population as
SELECT location,
       date,
	   total_cases,
	   population, 
	   (total_cases/population)*100 as covid_percentage_per_population
FROM CovidDeaths
WHERE location in ('Nigeria')
--ORDER BY total_cases 


CREATE VIEW Percentage_Infection_Rate as
SELECT location,
       population,
	   MAX(total_cases) as highest_infection_count,
	   MAX((total_cases/population))* 100 as percentage_infected_population
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
--ORDER BY percentage_infected_population desc


CREATE VIEW  Percentage_Death_Rate as
SELECT location,
       population, 
	   MAX(cast(total_deaths as int)) as highest_death_rate,
	   MAX((total_deaths/population)) *100 as percentage_death_population
FROM CovidDeaths
--WHERE continent is not null
GROUP BY location, population
--ORDER BY highest_death_rate desc



-- Querying a view
SELECT *
FROM Percent_population_vaccinated