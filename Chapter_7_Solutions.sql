/* Assignment Chapter 7 solution 
Agata Jelen Homework all answeres fixed*/


use my_drum_shop;

/* question 1 
Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. Instead, use a subquery in a WHERE clause that uses the IN keyword.
SELECT DISTINCT category_name
FROM categories c JOIN products p
  ON c.category_id = p.category_id
ORDER BY category_name

*/
SELECT DISTINCT
    category_name
FROM
    categories c
WHERE
    c.category_id IN (SELECT 
            category_id
        FROM
            products)
ORDER BY category_name;

/* question 2 
Write a SELECT statement that answers this question: Which products have a list price that’s greater than the average list price for all products?
Return the product_name and list_price columns for each product.
Sort the results by the list_price column in descending sequence. Should return 2 rows.
*/ 
SELECT 
    product_name, list_price
FROM
    products
WHERE
    list_price > (SELECT 
            AVG(list_price)
        FROM
            products)
ORDER BY list_price DESC;

/* question 3
Write a SELECT statement that returns the category_name column from the Categories table.
Return one row for each category that has never been assigned to any product in the Products table. To do that, use a subquery introduced with the NOT EXISTS operator.
Hint: running the following 2 queries should help check your answer
SELECT DISTINCT category_id, category_name FROM categories ORDER BY category_id;
SELECT DISTINCT category_id FROM products; 
*/
SELECT 
    category_name
FROM
    categories c
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            products p
        WHERE
            p.category_id = c.category_id);

/* question 4
Write a SELECT statement that returns three columns for each customer: 
email_address
order_id
SUM((item_price - discount_amount) * quantity) AS order_total 
To do this, you can group the result set by the email_address and order_id columns. In addition, you must calculate the order total from the columns in the Order_Items table. This will not require any subqueries, and it should produce the result below.

Write a second SELECT statement that uses the first SELECT statement in its FROM clause. 
The main query should return three columns: the customer’s email address, order_id and the largest order for that customer. 
To do this, you can group the result set by the email_address. This should return the following table

*/
SELECT 
    OrdTot.email_address, order_id, max_order_total
FROM
    (SELECT 
        email_address,
            o.order_id,
            SUM((item_price - discount_amount) * quantity) AS order_total
    FROM
        customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY email_address , order_id) OrdTot
        JOIN
    (SELECT 
        email_address, MAX(order_total) AS max_order_total
    FROM
        (SELECT 
        email_address,
            o.order_id,
            SUM((item_price - discount_amount) * quantity) AS order_total
    FROM
        customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY email_address , order_id) OrdTotCopy
    GROUP BY email_address) MaxOrdTot ON OrdTot.email_address = MaxOrdTot.email_address
        AND OrdTot.order_total = MaxOrdTot.max_order_total;

/* Note - query below is incorrect 
    Run this query and you will see the incorrect result.
SELECT email_address, order_id, MAX(order_total) AS max_order_total
FROM 	(
		SELECT 
			email_address,
			o.order_id,
			SUM((item_price - discount_amount) * quantity) AS order_total
		FROM
			customers c
				JOIN
			orders o ON c.customer_id = o.customer_id
				JOIN
			order_items oi ON o.order_id = oi.order_id
		GROUP BY email_address , order_id
		) t
GROUP BY email_address;
*/

/* question 5
Write a SELECT statement that returns the name and discount percent of each product that has a unique discount percent. 
In other words, don’t include products that have the same discount percent as another product.
Sort the results by the product_name column.
** Below you can see an alternative soultion to the same problem **
*/
SELECT 
    product_name, discount_percent
FROM
    products
WHERE
    discount_percent NOT IN (SELECT 
            discount_percent
        FROM
            products
        GROUP BY discount_percent
        HAVING COUNT(discount_percent) > 1)
ORDER BY product_name;

/* question 5, alternative solution */
SELECT 
    product_name, discount_percent
FROM
    products p
WHERE
    discount_percent NOT IN (SELECT DISTINCT
            discount_percent
        FROM
            products
        WHERE
            product_id != p.product_id)
ORDER BY product_name;

/* question 6 
Use a correlated subquery to return one row per customer, representing the customer’s oldest order (the one with the earliest date). 
Each row should include these three columns: email_address, order_id, and order_date.
*/
SELECT 
    email_address, order_id, order_date
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    order_date = (SELECT 
            MIN(order_date)
        FROM
            orders
        WHERE
            customer_id = o.customer_id);
