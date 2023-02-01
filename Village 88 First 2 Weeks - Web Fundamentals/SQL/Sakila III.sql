/*How many customers are there for each country?  Have your result display the full country name and the number of customers for each country.*/
SELECT country.country, COUNT(customer.customer_id) AS total_number_of_customer FROM customer
	INNER JOIN address ON address.address_id = customer.address_id
		INNER JOIN city ON city.city_id = address.city_id
			INNER JOIN country ON country.country_id = city.country_id
				GROUP BY country.country
					ORDER BY country.country asc;
					
/*How many customers are there for each city? Have your result display the full city name, the full country name, as
well as the number of customers for each city.
The resultset should show 1 total for each city, except:
- Australia's Woodridge = 0
- Canada's Lethbridge and London = 0
- United Kingdom's London = 2
- United State's Aurora = 2
*/

SELECT city.city, country.country, COUNT(customer.customer_id) AS total_customer FROM customer
	INNER JOIN address ON address.address_id = customer.address_id
		INNER JOIN city ON city.city_id = address.city_id
			INNER JOIN country ON country.country_id = city.country_id
				GROUP BY city.city
					ORDER BY COUNT(customer.customer_id) DESC, city.city ASC;
					
/*Now, look at the payment table where it has information about the customer as well as how much the customer paid to
rent the item. Based on this,*/
SELECT countrylanguage.`language`, SUM(country.Population * (countrylanguage.Percentage / 100)) AS total_population FROM country
	INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
		GROUP BY countrylanguage.`Language`
			ORDER BY total_population desc;

/*1. Retrieve both the average rental amount, the total rental amount, as well as the total number of transactions for
each month of each year.*/
SELECT CONCAT(MONTHNAME(payment_date), '-', YEAR(payment_date)) AS month_and_year, SUM(amount) AS total_rental_amount, COUNT(*) AS total_transactions, AVG(amount) AS average_rental_amount 
	FROM payment
		GROUP BY YEAR(payment_date), MONTH(payment_date)
			ORDER BY YEAR(payment_date), MONTH(payment_date);
			
/*Your manager comes and asks you to pull payment report based on the hour of the day. The managers wants to
know which hour the company earns the most money/payment. Have your sql query generate the top 10 hours of
the day with the most sales. Have the first row of your result be the hour with the most payments received. */
SELECT DATE_FORMAT(payment_date, '%l %p') AS hour_of_the_day, SUM(amount) AS total_payment_received FROM payment 
	GROUP BY DATE_FORMAT(payment_date, '%l %p')
		ORDER BY SUM(amount) DESC LIMIT 10;
		

