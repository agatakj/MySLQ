/*Chapter_3_Solutions
Agata Jelen CSD 138 - all problems fixed*/

USE my_drum_shop;

/* Question 1 
Write a SELECT statement that returns one column from the Customers table named full_name that concatenates the first_name and last_name columns.
Format this column with the last name, a comma, a space , and the first name like this:
Smith, Jane
Sort the result set by last name in descending sequence.
Return only the customers whose last name begins with letters from E to R.
*/
SELECT 
    CONCAT(last_name, ', ', first_name) AS full_name
FROM
    Customers
WHERE
    last_name REGEXP '^[E-R]'
    -- last_name REGEXP '^E|^F|^G|^H|^I|^J|^K|^L|^M|^N|^O|^P|^Q|^R’
    -- last_name >= ‘E’ AND last_name <= ‘R’
    -- LEFT(last_name,1) BETWEEN ‘E’ and ‘R’
    -- LEFT(last_name,1) IN (‘E’,’F’,’G’,’H’,’I’,’J’,’K’,’L’,’M’,’N’,’O’,’P’,’Q’,’R’)
ORDER BY last_name DESC;

/* Question 2
Write a SELECT statement that returns these columns from the Products table:
product_name	The product_name column
list_price	The list_price column
date_added	The date_added column
description	The description column
Return only the rows with a list price that’s greater than 100 and less than 1500.
Sort the result set in ascending sequence by the date_added column.
 */
SELECT
    product_name, list_price, date_added, description
FROM
    Products
WHERE
    list_price > 100 AND list_price < 1500
ORDER BY date_added ASC;
-- ORDER BY date_added;

/* Question 3 
Write a SELECT statement that returns these column names and data from the Products table:
product_name	The product_name column
list_price	The list_price column
discount_percent	The discount_percent column
discount_amount	A column that’s calculated from the previous two columns
discount_price	A column that’s calculated from the previous three columns
Round the discount_amount and discount_price columns to 2 decimal places.
Sort the result set by discount price in ascending sequence.
Use the LIMIT clause so the result set contains only rows 5-10.
*/
SELECT
    product_name, 
    list_price, 
    discount_percent, 
    ROUND(list_price * discount_percent / 100, 2) AS discount_amount, 
    ROUND(list_price * (1 - (discount_percent / 100)), 2) AS discount_price
    -- list_price - ROUND(list_price * discount_percent * .01, 2) AS 
      -- discount_price
FROM
    Products
ORDER BY discount_price ASC
-- ORDER BY discount_price
LIMIT 4, 6;

/* Question 4 
Write a SELECT statement that returns these column names and data from the Order_Items table:
item_id	The item_id column
item_price	The item_price column
discount_amount	The discount_amount column
quantity	The quantity column
price_total	A column that’s calculated by multiplying the item price by the quantity
discount_total	A column that’s calculated by multiplying the discount amount by the quantity
item_total	A column that’s calculated by subtracting the discount amount from the item price and then multiplying by the quantity
Only return rows where the item_total is less than 500.
Sort the result set by item total in ascending sequence.
*/ 
SELECT
    item_id,
    item_price,
    discount_amount,
    quantity,
    item_price * quantity AS price_total,
    discount_amount * quantity AS discount_total,
    (item_price - discount_amount) * quantity AS item_total
FROM
    Order_Items
WHERE (item_price - discount_amount) * quantity < 500
ORDER BY item_total ASC;
-- ORDER BY item_total;
-- ORDER BY (item_price - discount_amount) * quantity ASC;
-- ORDER BY (item_price - discount_amount) * quantity;

/*5.	
Write a SELECT statement that returns these columns from the Orders table:
order_id	The order_id column
order_date	The order_date column
ship_date	The ship_date column
ship_amount	The ship_amount column
Return only the rows where the ship_date column contains a null value.
Sort the result by order_date in descending sequence.*/
SELECT
    order_id, order_date, ship_date, ship_amount
FROM
    Orders
WHERE ship_date IS NULL
-- WHERE ISNULL(ship_date)
ORDER BY order_date DESC;

/* Question 6 
Write a SELECT statement without a FROM clause that uses the NOW function to create a row with these columns:
today_unformatted	The NOW function unformatted
today_formatted	The NOW function in this format: 
month/day/year – i.e., 01/08/2018
The today_formatted date displays in USA typical date format.
*/
SELECT
    NOW() AS today_unformatted,
    -- CURRENT_DATE AS today_unformatted,
    DATE_FORMAT(NOW(), '%m/%d/%Y') AS today_formatted;
    -- DATE_FORMAT( CURRENT_DATE ,'%m/%d/%Y') AS today_formatted;

/* Question 7 
Write a SELECT statement without a FROM clause that creates a row with these columns:
price	1000 (dollars)
tax_rate	.09 (9 percent)
tax_amount	The price multiplied by the tax
total	The price plus the tax
To calculate the fourth column, add the expressions you used for the first and third columns
*/
SELECT
    1000 AS price,
    0.09 AS tax_rate,
    1000 * 0.09 AS tax_amount,
    (1000) + (1000 * .09) AS total;
    -- 1000 * 1.09 AS total;
