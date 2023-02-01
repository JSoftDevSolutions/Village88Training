/*1. How many countries in each continent have life expectancy greater than 70?*/
SELECT Continent, COUNT(country.Name) AS country_account, LifeExpectancy FROM country WHERE country.LifeExpectancy > 70 GROUP BY Continent;

/*How many countries in each continent have life expectancy between 60 and 70?*/
SELECT Continent, COUNT(country.Name) AS country_account, LifeExpectancy FROM country WHERE country.LifeExpectancy BETWEEN 60 AND 70 GROUP BY Continent;

/*How many countries have life expectancy greater than 75?*/
SELECT country.Name AS country, LifeExpectancy FROM country WHERE country.LifeExpectancy > 75;

/*How many countries have life expectancy less than 40?*/
SELECT country.Name AS country, LifeExpectancy FROM country WHERE country.LifeExpectancy < 40;

/*How many people live in the top 10 countries with the most population?*/
SELECT country.Name AS country, Population FROM country ORDER BY Population DESC LIMIT 10;

/*According to the world database, how many people are there in the world?*/
SELECT SUM(Population) AS total_population FROM country;

/*Show results for continents where it shows the continent name and the total population. Only show results
where the total_population for the continent is more than 500,00,000. If. the continent doesn't have
500,000,000 people, do NOT show the result.*/

SELECT continent, SUM(country.Population) AS total_populations 
	FROM  country  GROUP BY continent  
		HAVING SUM(country.Population) > 500000000 
			ORDER BY SUM(country.Population) desc;
			
/*Show results of all continents that has average life expectancy for the continent to be
less than 71. Show each of these continent name, how many countries there are in each of the continent, total
population for the continent, as well as the life expectancy of this continent. For example, as Europe and North
America both have continent life expectancy greater than 71, these continents shouldn't show up in your sql
results.*/
SELECT continent, count(NAME) AS country, SUM(population) AS total_population, AVG(lifeexpectancy) AS life_expectancy FROM country
		GROUP BY continent
			HAVING AVG(lifeexpectancy) < 71;
	


/*Now that you've used the group by a bit, let's now have you use this together with other records that were joined from
multiple tables.*/

/*Now, write a SQL query to obtain answers to the following questions:*/

/*1. How many cities are there for each of the country? Show the total city count for each country where you
display the full country name.*/

SELECT country.Name AS country, COUNT(city.Name) AS number_of_cities
	FROM country
		LEFT JOIN city ON city.CountryCode = country.Code
			GROUP BY country.Name;
			
/*2. For each language, find out how many countries speak each language.*/

SELECT country.Name AS country, countrylanguage.`Language`, COUNT(countrylanguage.CountryCode) AS number_of_countries
	FROM countrylanguage
		INNER JOIN country ON  country.Code = countrylanguage.CountryCode
		GROUP BY countrylanguage.`Language`
			ORDER BY country.Name;		
			
/*3. For each language, find out how many countries use that language as the official language.*/

SELECT LANGUAGE, COUNT(LANGUAGE) AS total_countries, isofficial 
	FROM countrylanguage
		GROUP BY LANGUAGE, isofficial
			HAVING isofficial = 'T';

/*4. For each continent, find out how many cities there are (according to this database) and the average population
of the cities for each continent. For example, for continent A, have it state the number of cities for that
continent, and the average city population for that continent.*/

SELECT continent, COUNT(city.Name) AS total_cities, AVG(city.Population) AS average_cities_population FROM country
	INNER JOIN city ON city.CountryCode = country.code
		GROUP BY continent;
	
/*(Advanced) Find out how many people in the world speak each language. Make sure the total sum of. this
number is comparable to the total population in the world.*/
SELECT countrylanguage.`language`, SUM(country.Population * (countrylanguage.Percentage / 100)) AS total_population FROM country
	INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
		GROUP BY countrylanguage.`Language`
			ORDER BY total_population DESC;















