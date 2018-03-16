
/* Chapter 5 Assignment solutions 
Agata Jelen CSD 138
*/


use my_drum_shop;

/* Question 1 
Write an INSERT statement that adds this row to the Categories table:
category_name:	Brass
Code the INSERT statement so MySQL automatically generates the category_id column.

*/
insert into categories (category_id, category_name)
values
(DEFAULT, 'Brass');

-- Question 1 alternative solution 
INSERT INTO categories
VALUES (DEFAULT, 'Brass');

-- Question 1 alternative solution 
INSERT INTO categories (category_name)
VALUES ('Brass');

/* Question 2.	
Write an UPDATE statement that modifies the row you just added to the 
Categories table. This statement should change the category_name column to “Woodwinds”, 
and it should use the category_id column to identify the row.
*/
UPDATE categories 
SET 
    category_name = 'Woodwinds'
WHERE
    category_id = 6;

/* Question 3.
Write a DELETE statement that deletes the row you added to the Categories table in exercise 1. 
This statement should use the category_id column to identify the row.
*/
DELETE FROM categories 
WHERE
    category_id = 6;

/* Question 4.
Write an INSERT statement that adds this row to the Products table:
product_id:	The next automatically generated ID 
category_id:	4
product_code:	dgx_640
product_name:	Yamaha DGX 640 88-Key Digital Piano
description:	Long description to come.
list_price:	799.99
discount_percent:	0
date_added:	Today’s date/time.
Use a column list for this statement.
*/

insert into products
(product_id, category_id, product_code, product_name,
description, list_price, discount_percent, date_added)
values
(default, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano',
'Long description to come', 799.99, 0, NOW());

/* Question 5 
Write an UPDATE statement that modifies the product you added in exercise 4. 
This statement should change the discount_percent column from 0% to 35%.
*/
UPDATE products 
SET 
    discount_percent = 35
WHERE
    product_id = 11;
    

/* Question 6 
Write an INSERT statement that adds this row to the Customers table:
email_address:	rick@raven.com
password:	(empty string)
first_name:	Rick
last_name:	Raven
Use a column list for this statement.
*/

insert into customers 
(email_address, password, first_name, last_name)
values
('rick@raven.com', '', 'Rick', 'Raven');

/* Question 7.	Write an UPDATE statement that modifies the Customers table. 
Change the password column to “secret” for the customer with an email address of rick@raven.com.
*/
UPDATE customers 
SET 
    password = 'secret'
WHERE
    email_address = 'rick@raven.com';

-- another possible solution to the same problem (7)
UPDATE customers 
SET 
    password = 'secret'
WHERE
    customer_id = 9;

/* Question 8.	
Write an UPDATE statement that modifies the Customers table. 
Change the password column to “reset” for every customer in the table. 
If you get an error due to safe-update mode, you can add a LIMIT clause to update the first 100 rows of the table. (This should update all rows in the table.)
*/
UPDATE customers 
SET 
    password = 'reset'
LIMIT 100;


/*9 Open the script named create_my_drum_shop.sql that’s in Module 1. Then, run this script. That should restore the data that’s in the database.*/
