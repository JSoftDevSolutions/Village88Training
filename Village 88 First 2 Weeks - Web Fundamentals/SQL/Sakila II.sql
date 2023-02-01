/*1. Get all the list of customers.*/;
SELECT * FROM customer;

/*2. Get all the list of customers as well as their address.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id;
		
/*3. Get all the list of customers as well as their address and the city name.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address, city.city
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id;
		
/*4. Get all the list of customers as well as their address, city name, and the country.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address, city.city, country.country
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id;
				
/*5. Get all the list of customers who live in Bolivia*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address, city.city, country.country
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE country.country = 'Bolivia';
					
/*6. Get all the list of customers who live in Bolivia, Germany and Greece*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address, city.city, country.country
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE country.country IN ('Bolivia', 'Germany', 'Greece');
					
/*7. Get all the list of customers who live in the city of Baku.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address, city.city, country.country
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE city.city = 'Baku';
/*8. Get all the list of customers who live in the city of Baku, Beira, and Bergamo.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, address.address, city.city, country.country
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE city.city IN ('Baku', 'Beira', 'Bergamo');
					
/*9. Get all the list of customers who live in a country where the country name's length is less than 5.  
Show the customer with the longest full name first.  (Hint:  Look into how you can concatenate a string in SQL).*/;

SELECT CONCAT(first_name,' ', last_name) AS customer_name, country.country,
	LENGTH(country.country) AS country_length
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE LENGTH(country.country) < 5 ORDER BY LENGTH(CONCAT(first_name, last_name)) desc;
					
/*10. Get all the list of customers who live in a city name whose length is more than 10.  Order the result so that the customers who live in the same country are shown together.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, country.country, city.city,
	LENGTH(city.city) AS city_name_length
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE LENGTH(city.city) > 10 ORDER BY country.country asc;
					
/*11. Get all the list of customers who live in a city where the city name includes the word 'ba'.  For example Arratuba or Baiyin  should show up in your result.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, city.city
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE city.city LIKE '%ba%' ORDER BY city.city;

/*12. Get all the list of customers where the city name includes a space.  Order the result so that customers who live in the longest city are shown first.*/;
SELECT CONCAT(first_name,' ', last_name) AS customer_name, city.city, LENGTH(city.city) AS city_name_length
	FROM customer
		INNER JOIN address ON address.address_id = customer.address_id
			INNER JOIN city ON city.city_id = address.city_id
				INNER JOIN country ON country.country_id = city.country_id
					WHERE city.city LIKE '% %' ORDER BY LENGTH(city.city) DESC;

/*13. Get all the customers where the country name is longer than the city name.*/
SELECT CONCAT(first_name,' ', last_name) AS customer_name, city.city, country.country,
	LENGTH(city.city) AS city_name_length, LENGTH(country.country) AS country_name_length
		FROM customer
			INNER JOIN address ON address.address_id = customer.address_id
				INNER JOIN city ON city.city_id = address.city_id
					INNER JOIN country ON country.country_id = city.country_id
						WHERE LENGTH(country.country) > LENGTH(city.city);


