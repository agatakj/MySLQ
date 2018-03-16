/* Chapter 4 Solutions, checked and fixed 
Agata Jelen CSD 138*/

use my_drum_shop;

/* question 1.	
Write a SELECT statement that inner joins the Products table to the Categories table and returns the columns product_name, category_name, and list_price with the aliases Product, Category, and Price, respectively.
Sort the result set by Category and then by Price in ascending sequence.
*/
SELECT 
    p.product_name as Product, 
    c.category_name as Category, 
    p.list_price as Price
FROM
    products p
        INNER JOIN
    categories c ON p.category_id = c.category_id
ORDER BY Category, Price;

/* question 2.	
Write a SELECT statement that inner joins the Customers table to the 
Addresses table and returns last_name and first_name columns with aliases Last and First, respectively.  
Also, return the address for each customer by concatenating the line1, 
city, state, and zip_code fields in the format “One Microsoft Way, Redmond, WA, 98052”.  Use the alias Address for this column.
Finally, return one row for each customer address with an email address other than erinv@gmail.com.  
Sort by Last name, then First name in ascending order.
*/
SELECT 
    c.last_name as Last,
    c.first_name as First,
    CONCAT(a.line1, ', ', a.city, ', ', a.state, ', ', a.zip_code) as Address
FROM
    customers c
        INNER JOIN
    addresses a ON c.customer_id = a.customer_id
WHERE
    c.email_address != 'erinv@gmail.com'
ORDER BY Last, First;

/* question 3.	
Write a SELECT statement that inner joins the Customers table to the Addresses table and returns the same columns as in question 2, 
except use the alias ‘Billing Address’ instead of ‘Address’ for the last column.
Return one row for each customer, but only return addresses that are the billing address for a customer.  Sort by Last name in descending order.
*/
SELECT 
    c.last_name as Last,
    c.first_name as First,
    CONCAT(a.line1, ', ', a.city, ', ', a.state, ', ', a.zip_code) as 'Billing Address'
FROM
    customers c
        INNER JOIN
    addresses a ON c.customer_id = a.customer_id
    	      AND c.billing_address_id = a.address_id
-- WHERE
    -- c.billing_address_id = a.address_id
ORDER BY Last DESC;

/* question 4.	
Write a SELECT statement that inner joins the Customers, Orders, Order_Items, and Products tables. This statement should return these columns: last_name, first_name, order_date, product_name, item_price, discount_amount, and quantity.
Use aliases for the tables.
Sort the final result set by last_name, order_date, and product_name all in ascending order.
 */
SELECT 
    c.last_name,
    c.first_name,
    o.order_date,
    p.product_name,
    oi.item_price,
    oi.discount_amount,
    oi.quantity
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
        JOIN
    products p ON oi.product_id = p.product_id
ORDER BY c.last_name , o.order_date , p.product_name;

/* question 5.	
Write a SELECT statement that returns the product_name and list_price columns from the Products table.
Return one row for each product that has the same list price as another product. 
Hint: check that the product_id columns aren’t equal but the list_price columns are equal.
Sort the result set by product_name in descending order.
*/
SELECT 
    p1.product_name, p1.list_price
FROM
    products p1
        JOIN
    products p2 ON p1.product_id != p2.product_id
        AND p1.list_price = p2.list_price
-- WHERE
    -- p1.list_price = p2.list_price
ORDER BY p1.product_name DESC;

/* question 6.	
Write a SELECT statement that returns these two columns: 
category_name	The category_name column from the Categories table
product_id	The product_id column from the Products table
Return one row for each category that has never been used. 
Hint: Use an outer join and only return rows where the product_id column contains a null value.
Order by category_name in descending order.
 */
SELECT 
    c.category_name, p.product_id
FROM
    categories c
        LEFT OUTER JOIN
    products p ON c.category_id = p.category_id
WHERE
    p.product_id IS NULL
ORDER BY c.category_name DESC;

/* question 7.
Use the UNION operator to generate a result set consisting of three columns from the Orders table: 
ship_status	A calculated column that contains a value of SHIPPED or NOT SHIPPED
order_id	The order_id column
order_date	The order_date column
If the order has a value in the ship_date column, the ship_status column should contain a value of SHIPPED. Otherwise, it should contain a value of NOT SHIPPED.
Sort the final result set by order_date in descending order.
 */
SELECT 
    'SHIPPED' AS ship_status, order_id, order_date
FROM
    orders
WHERE
    ship_date IS NOT NULL 
UNION SELECT 
    'NOT SHIPPED' AS ship_status, order_id, order_date
FROM
    orders
WHERE
    ship_date IS NULL
ORDER BY order_date DESC;
