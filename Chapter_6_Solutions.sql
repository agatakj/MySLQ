
/* Solution Chapter 6 checked errors fixed
homework assignment Agata Jelen CSD 138 */

use my_drum_shop;

/* question 1.	
The count of products in the products table
The sum of the list_price column in the products table
Use appropriate column aliases for both columns.
*/
SELECT 
    COUNT(*) AS number_of_products,
    SUM(list_price) AS sum_of_list_price
FROM
    products;

/* question 2.	
Write a SELECT statement that returns one row for each category that has products with these columns:
The category_name column from the Categories table
The count of the products in the Products table for a particular category
The average price of the products for a particular category rounded to two decimal places
Use appropriate appropriate aliases for all columns and tables.
Sort the result set so that the category with the most products appears first.
*/
SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.list_price), 2) as average_price
FROM
    categories c
        JOIN
    products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC;

/* question 3.	
Write a SELECT statement that returns one row for each customer that has orders with these columns:
The email_address column from the Customers table
The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table
The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table
Use appropriate aliases for all columns and tables.
Sort the result set in ascending sequence by the second column.
 */
SELECT 
    c.email_address AS email,
    SUM(oi.item_price * quantity) AS item_price_total,
    SUM(oi.discount_amount * quantity) AS discount_total
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
ORDER BY item_price_total ASC;

/* question 4.	
Write a SELECT statement that returns one row for each customer that has orders with these columns:
The email_address from the Customers table
A count of the number of orders
The total amount for each order (Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.)
Use appropriate aliases for all columns and tables.
Return only those rows where the customer has less than 3 orders.
Sort the result set in ascending sequence by the sum of the line item amounts.
 */
SELECT 
    c.email_address AS email,
    COUNT(o.order_id) AS number_orders,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS sum_of_line_item_amounts
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING number_orders < 3
ORDER BY sum_of_line_item_amounts ASC;

/* question 5.	
Modify the solution to exercise 4 so it only counts and totals line items that have an item_price value that’s greater than 500. */ 
SELECT 
    c.email_address AS email,
    COUNT(o.order_id) AS number_orders,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS sum_of_line_item_amounts
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE oi.item_price > 500
GROUP BY c.email_address
HAVING number_orders < 3
ORDER BY sum_of_line_item_amounts ASC;

/* question 6.
Write a SELECT statement that answers this question: What is the total amount ordered for each product? Return these columns:
The product name from the Products table
The total amount for each product in the Order_Items (Hint: You can calculate the total amount by subtracting the discount amount from the item price and then multiplying it by the quantity)
Use appropriate aliases for all columns and tables.
Sort the result set by product name in descending order.
Use the WITH ROLLUP operator to include a final row that gives the grand total.
*/
SELECT 
    p.product_name,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS total_amount
FROM
    products p
        JOIN
    order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name DESC WITH ROLLUP;

/* question 7.	
Write a SELECT statement that answers this question: Which customers have ordered more than one product (ignore multiple orders for same product)? Return these columns:
The email address from the Customers table
The count of distinct products from the customer’s orders
Use appropriate aliases for all columns and tables.
Sort the result set by the number distinct products in descending order.
 */
SELECT 
    c.email_address, 
    COUNT(DISTINCT oi.product_id) AS number_products
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING number_products > 1
ORDER BY number_products DESC;
