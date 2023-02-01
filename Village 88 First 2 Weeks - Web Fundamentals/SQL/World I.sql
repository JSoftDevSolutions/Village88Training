/*1. Get all the list of countries that are in the continent of Europe*/
SELECT * FROM country WHERE Continent = 'Europe';

/*Get all the list of countries that are in the continent of North America and Africa*/
SELECT * FROM country WHERE Continent IN('North America', 'Africa');

/*2. Get all the list of cities that are part of a country with population greater than 100 millions.*/
SELECT country.Code AS country_code, country.Name AS country_name, country.Continent, 
	country.Population AS country_population, city.Name AS city
		FROM country 
			INNER JOIN city ON city.CountryCode = country.code
			WHERE country.Population > 100000000;
			
/*3. Get all the list of countries (display the full country name) who speak 'Spanish' as their language*/
SELECT country.Name AS country, countrylanguage.`Language` AS 'language' FROM country
	LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
		WHERE countrylanguage.`Language` = 'Spanish';
		
/*4. Get all the list of countries (display the full country name) who speak 'Spanish' as their official language*/
SELECT country.Name AS country, countrylanguage.`Language` AS 'language', countrylanguage.IsOfficial
	FROM country
		LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
			WHERE countrylanguage.`Language` = 'Spanish' AND countrylanguage.IsOfficial = 'T';
/*5. Get all the list of countries (display the full country name) who speak either 'Spanish' or 'English' as their official language*/
SELECT country.Name AS country, countrylanguage.`Language` AS 'language'
	FROM country
		LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
			WHERE (countrylanguage.`Language` = 'Spanish' AND countrylanguage.IsOfficial = 'T') 
			OR (countrylanguage.`Language` = 'English' AND countrylanguage.IsOfficial = 'T');
			
/*6. Get all the list of countries (display the full country name) where 'Arabic' is spoken by more than 30% of the population but where it's not the country's official language.*/
SELECT country.Name AS country, countrylanguage.`Language` AS 'language',
	countrylanguage.Percentage, countrylanguage.IsOfficial
	FROM country
		LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
			WHERE countrylanguage.`Language` = 'Arabic' and countrylanguage.Percentage > 30 AND countrylanguage.IsOfficial = 'F';
			
/*7. Get all the list of countries (display the full country name) where 'French' is the official language 
but where less than 50% of the population in that country actually speaks that language.*/
SELECT country.Name AS country, countrylanguage.`Language` AS 'language',
	countrylanguage.IsOfficial, countrylanguage.Percentage
	FROM country
		LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
			WHERE countrylanguage.`Language` = 'French' AND countrylanguage.IsOfficial = 'T' AND countrylanguage.Percentage < 50 ;
			
/*8. Get all the list of countries (display the full country name and the full language name) and their official language.  
Order the result so that those with the same official language are shown together.*/
SELECT country.Name AS country, countrylanguage.`Language` AS 'language', countrylanguage.IsOfficial
	FROM country
		LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
			WHERE countrylanguage.IsOfficial = 'T' ORDER BY countrylanguage.`Language`;
			
/*9. Get the top 100 cities with the most population.  Display the city's full country name also as well as their official language.*/
SELECT country.Name AS country, city.Name AS city, countrylanguage.`Language` AS 'language', countrylanguage.IsOfficial
	FROM country
		LEFT JOIN city ON city.CountryCode = country.Code
			LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
				WHERE countrylanguage.IsOfficial = 'T' ORDER BY city.Population desc LIMIT 100;
				
/*10. Get the top 100 cities with the most population where the life_expectancy for the country is less than 40.*/
SELECT country.Name AS country, country.LifeExpectancy, city.Name AS city, city.Population
	FROM country
		LEFT JOIN city ON city.CountryCode = country.Code
			WHERE country.LifeExpectancy < 40 ORDER BY city.Population desc LIMIT 100;
			
/*11. Get the top 100 countries who speak English and where life expectancy is highest.  Show the country with the highest life expectancy first.*/
SELECT country.Name AS country, city.Name AS city, country.LifeExpectancy
	FROM country
		LEFT JOIN city ON city.CountryCode = country.Code
			LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
				WHERE countrylanguage.`Language` = 'English' ORDER BY country.LifeExpectancy desc LIMIT 100;
