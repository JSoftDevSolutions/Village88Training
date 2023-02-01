/*1. What query would you run to get all the sites that client=15 owns?*/
use lead_gen_business;
SELECT sites.domain_name AS website, client_id 
	FROM sites WHERE client_id = '15';
	
/*2. What query would you run to get total count of domain created for June 2011?*/
use lead_gen_business;
SELECT MONTHNAME(created_datetime) AS MONTH, COUNT(*) AS total_count
	FROM sites WHERE YEAR(created_datetime) = '2011' AND MONTHNAME(created_datetime) = 'June';
	
/*3. What query would you run to get the total revenue for the date November 19th 2012?*/

SELECT DATE_FORMAT(charged_datetime, '%Y-%m-%d') AS DATE, SUM(amount) AS revenue
	FROM billing WHERE DATE_FORMAT(charged_datetime, '%Y-%m-%d') = '2012-11-19';
	
/*4. What query would you run to get total revenue earned monthly each year for the client with an id of 1?*/
SELECT client_id, SUM(amount) AS total_revenue, MONTHNAME(charged_datetime) AS 'month', DATE_FORMAT(charged_datetime, '%Y') AS 'year' 
	FROM billing 
		GROUP BY CONCAT(MONTHNAME(charged_datetime), '-', YEAR(charged_datetime)), client_id
			HAVING client_id = '1'
				ORDER BY YEAR(charged_datetime), MONTHNAME(charged_datetime);
				
/*5. What query would you run to get total revenue of each client every month per year? Order it by client id.*/
SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, SUM(amount) AS total_revenue, MONTHNAME(billing.charged_datetime) AS MONTH,
	DATE_FORMAT(billing.charged_datetime, '%Y') AS 'year'
	FROM billing
		INNER JOIN clients ON clients.client_id = billing.client_id
			GROUP BY CONCAT(MONTHNAME(charged_datetime), YEAR(charged_datetime)), billing.client_id
				ORDER BY billing.client_id, YEAR(billing.charged_datetime), Month(billing.charged_datetime);
				
/*6. What query would you run to get which sites generated leads between March 15, 2011 to April 15, 2011? Show how many leads for each site. */
SELECT sites.domain_name AS website, (SELECT COUNT(*) FROM leads WHERE leads.site_id = sites.site_id AND DATE_FORMAT(leads.registered_datetime, '%Y-%m-%d') BETWEEN '2011-03-15' AND '2011-04-15') AS number_of_leads 
	FROM sites
		INNER JOIN leads ON leads.site_id = sites.site_id
			WHERE DATE_FORMAT(leads.registered_datetime, '%Y-%m-%d') BETWEEN '2011-03-15' AND '2011-04-15';

SELECT sites.domain_name AS website, COUNT(leads_id) AS number_of_leads 
	FROM sites
		LEFT JOIN leads ON leads.site_id = sites.site_id
			WHERE DATE_FORMAT(leads.registered_datetime, '%Y-%m-%d') BETWEEN '2011-03-15' AND '2011-04-15'
				GROUP BY sites.domain_name
					order by sites.client_id desc;

/*7. What query would you run to show all the site owners, the site name(s), and the total number of leads generated from each site for all time?*/
SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, sites.domain_name,
	(SELECT COUNT(*) FROM leads WHERE leads.site_id = sites.site_id) AS num_leads
	FROM sites
		INNER JOIN clients ON clients.client_id = sites.client_id
			ORDER BY clients.client_id, sites.domain_name;
			
/*8. What query would you run to get a list of site owners who had leads, and the total of each for the whole 2012?*/
SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS 'client', 
	(SELECT COUNT(*) FROM leads WHERE leads.site_id IN (SELECT sites.site_id FROM sites WHERE sites.client_id = clients.client_id) AND DATE_FORMAT(leads.registered_datetime, '%Y') = '2012') AS number_of_leads
		FROM leads
			INNER JOIN sites ON sites.site_id = leads.site_id
				INNER JOIN clients ON clients.client_id = sites.client_id
					GROUP BY clients.client_id HAVING number_of_leads > 0;
					
/*9. What query would you run to get a list of site owners and the total 
# of leads we've generated for each owner per month for the first half of Year 2012?*/
SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, COUNT(*) AS num_leads, MONTHNAME(leads.registered_datetime) AS 'month' FROM clients
	INNER JOIN sites ON sites.client_id = clients.client_id
		INNER JOIN leads ON leads.site_id = sites.site_id
			WHERE MONTH(leads.registered_datetime) <= 6 AND DATE_FORMAT(leads.registered_datetime, '%Y') = '2012'
				GROUP BY MONTH(leads.registered_datetime), sites.client_id ORDER BY MONTH(leads.registered_datetime), clients.first_name;

/*10. Write a single query that retrieves all the site names that each client owns and its total count. 
Group the results so that each row shows a new client. (Tip: use GROUP_CONCAT)*/
SELECT CONCAT(first_name, ' ', last_name) AS client_name, 
	(SELECT COUNT(*) FROM sites WHERE sites.client_id = clients.client_id) AS number_of_sites,
	(SELECT GROUP_CONCAT(CONCAT(domain_name) SEPARATOR ', ') FROM sites WHERE sites.client_id = clients.client_id) AS 'sites'
		FROM clients;







