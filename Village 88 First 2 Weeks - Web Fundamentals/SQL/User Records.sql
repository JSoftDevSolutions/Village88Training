/*What's the query for creating this new database table with the fields above?*/;

CREATE DATABASE hackerhero_practice;

USE hackerhero_practice;

CREATE TABLE Users (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	email VARCHAR(255),
	encrypted_password VARCHAR(255),
	created_at DATETIME,
	updated_at DateTime
);

/*What's the query for inserting new records into this table?  Write queries for inserting three fake users into the table (one query for each insert).*/;
INSERT INTO users(first_name, last_name, email, encrypted_password, created_at) VALUES('MARY', 'SMITH', 'MARY.SMITH@sakilacustomer.org', 'sampleencrypted', NOW());
INSERT INTO users(first_name, last_name, email, encrypted_password, created_at) VALUES('ELIZABETH', 'BROWN', 'ELIZABETH.BROWN@sakilacustomer.org', 'sampleencrypted', NOW());
INSERT INTO users(first_name, last_name, email, encrypted_password, created_at) VALUES('PATRICIA', 'JOHNSON', 'PATRICIA.JOHNSON@sakilacustomer.org', 'sampleencrypted', NOW());

/*What's the query for updating one of the user records?  For example, if you wanted to update the user record for id = 1, with some fake data, what would the query be?*/;
UPDATE users SET first_name = 'Updated FirstName', last_name = 'Updated LastName', updated_at = NOW() WHERE id = '3';

/*What query would you run for updating all of the user records with the last_name of 'Choi'?*/;
UPDATE users SET last_name = 'Choi';

/*What query would you run for updating all the user records where ID is 3, 5, 7, 12, or 19?*/;
UPDATE users SET last_name = 'Choi' WHERE id IN('3', '5', '7', '12') OR Id = '19';

/*What's the query for deleting a user record where id = 1?*/;
DELETE FROM users WHERE id = '1';

/*What's the query for deleting the entire users records in the users table?*/;
DELETE FROM users;

/*What's the query for dropping the entire users table?  What's the difference between dropping the table and deleting all records?*/;
DROP TABLE users; /*Dropping the table will delete the entire table including the datas in that table while deleting all records will only delete the records inside the table*/;

/*What's the query for altering the email field to have it be 'email_address' instead?*/;
ALTER TABLE users CHANGE COLUMN email email_address VARCHAR(255);

/*What's the query for altering the id so that it's a BIGINT instead?*/;
ALTER TABLE users CHANGE id id BIGINT;

/*What's the query for adding a new field to the users table called is_active where it's a Boolean (meaning it's either a 0 or a 1).  
Imagine you wanted the default value of this to be 0 when a new record is created and you won't allow this field to ever be NULL.  
With this in mind, now come up with a query.*/;
ALTER TABLE users ADD is_active TINYINT DEFAULT '0' NOT NULL;



