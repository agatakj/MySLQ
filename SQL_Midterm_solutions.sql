/*Midterm Files*/

use classicmodels;

/* Question 1 
1.	Find all Classic Cars that do not have the scale numbers 1:24. Include product name, scale, 
and description in the result. Name the columns as shown in the screenshot below (only partial results shown). Sort ascending by Scale and then Car Name.  
Hint: Result has 27 rows.  All information is in the products table - no join is required.
*/
SELECT 
    productName AS 'Car Name',
    productScale AS Scale,
    productDescription AS Description
FROM
    products
WHERE
    productScale != '1:24'
        AND productLine = 'Classic Cars'
ORDER BY productScale , productName;

/* Question 2 
1.	Find customer names and order details of all the non-Australia and non-New-Zealand 
customers whose order status is NOT ‘shipped’, ‘resolved’, or ‘in process’.  
Include the following columns: customerName, country, status, productName, and quantityOrdered as shown in screenshot below. Sort by country in ascending order then quantityOrdered in descending order.  
Hint: Returns 113 rows.  You will need to join 4 tables.

*/
SELECT 
    c.customerName AS Customer, 
    c.customerNumber AS Number, 
    c.country AS Country
FROM
    customers c
        LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
WHERE
	c.country IN ('Spain', 'Switzerland') AND
--    (c.country = 'Spain' OR c.country = 'Switzerland') AND
    o.orderNumber IS NULL
ORDER BY c.customerName;

/* Question 3 
1.	Find out how many orders were made by customers with names starting from letters ‘A’, ‘B’, ‘M’ or ‘S’. 
Retrieve only those who made at least 2 orders. The resulting table should have 2 columns: customerName and orderCount (number of orders made) as shown in screenshot below. Sort descending by orderCount.  
Hint: Result has 35 rows.  You will need to use GROUP BY and HAVING.

*/
SELECT 
    c.customerName, c.country, o.status, p.productName, od.quantityOrdered
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
        JOIN
    products p ON od.productCode = p.productCode
WHERE
	c.country NOT IN ('Australia', 'New Zealand') AND
      o.status NOT IN ('shipped', 'resolved', 'in process')
--  c.country != 'Australia' AND c.country != 'New Zealand' AND
--	  o.status != 'shipped' AND o.status != 'resolved' AND o.status != 'In Process'
ORDER BY c.country ASC, od.quantityOrdered DESC;

/* Question 4 
1.	Find out the total value of orders for each customer in the USA and France ordered from the productLine ‘Motorcycles’. 
The total value of an order is the sum of priceEach * quantityOrdered. Order the result by total value descending as shown in screenshot below. 
Hint: Result has 28 rows. Join 4 tables, use WHERE and HAVING clauses.

*/
SELECT 
    c.customerName, COUNT(orderNumber) AS orderCount
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
WHERE -- Could be in HAVING
	c.customerName REGEXP '^[A,B,M,S]'
--	c.customerName REGEXP '^A|^B|^M|^S'
GROUP BY c.customerName
HAVING orderCount > 1 
ORDER BY orderCount DESC;

/* Question 5 
1.	Build the following queries: 
i.	Find the total order amount for each order that has not shipped (i.e., any status value other than ‘shipped’).  Return the columns in the screenshot shown below. 
Hint: Result has 23 rows. Use an aggregate function in SELECT clause to sum up the priceEach multiplied by quantityOrdered, join the orders and orderDetails tables, and GROUP by customerNumber, orderNumber and status.
ii.	Using the query above, get the average order amount for all customer orders that have not shipped.  
Hint: average of all orders that have not shipped should be 32134.61
iii.	 Return the customer orders that have not shipped and have a larger than the average order amount for all orders that have not shipped.  Return columns as shown in the screenshot below sorted by orderAmount in descending order.  
Hint: Result has 12 rows. Use the answer to part ii as a subquery in the HAVING clause of an outer query that is similar to your answer for part i with one more join on customers to pick up the customer name which replaces customerNumber.

*/
SELECT 
    c.customerName,
    c.country,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) as totalValue
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
        JOIN
    products p ON od.productCode = p.productCode
WHERE
    p.productLine = 'Motorcycles'
GROUP BY c.customerName, c.country
HAVING 
	c.country IN ('USA', 'France')
--	c.country = 'USA' or c.country = 'France'
ORDER BY totalValue DESC;

/* Question 6 */
/* Find sum of each customer order where status is not shipped */
SELECT 
    o1.customerNumber,
    o1.orderNumber,
    o1.status,
    ROUND(SUM(od1.priceEach * od1.quantityOrdered), 2) AS orderAmount
FROM
    orders o1 JOIN
       orderdetails od1 ON o1.orderNumber = od1.orderNumber
WHERE o1.status != 'shipped'
GROUP BY o1.customerNumber , o1.orderNumber , o1.status;
                
/* Find average of all orders that have not shipped */
SELECT ROUND(AVG(t1.orderAmount), 2) as AverageOrder
		  FROM (SELECT o1.customerNumber, 
                       o1.orderNumber, 
                       o1.status, 
                       ROUND(SUM(od1.priceEach * od1.quantityOrdered), 2) AS orderAmount
				FROM orders o1 JOIN
						orderdetails od1 ON o1.orderNumber = od1.orderNumber
				WHERE o1.status != 'shipped'
				GROUP BY o1.customerNumber, o1.orderNumber, o1.status) t1;
                
/* Find customer orders that have not shipped that are greater or equal to 
   to the average customer order that has not shipped - use queries above
   to put it all together */                
SELECT c.customerName, o.orderNumber, o.status,
	   ROUND(SUM(od.priceEach * od.quantityOrdered), 2) as orderAmount
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
WHERE o.status != 'shipped'
GROUP BY c.customerName, o.orderNumber, o.status
HAVING orderAmount >
	    ( SELECT ROUND(AVG(t1.orderAmount), 2)
		  FROM (SELECT o1.customerNumber, o1.orderNumber, o1.status, ROUND(SUM(od1.priceEach * od1.quantityOrdered), 2) AS orderAmount
				FROM orders o1 JOIN
						orderdetails od1 ON o1.orderNumber = od1.orderNumber
				WHERE o1.status != 'shipped'
				GROUP BY o1.customerNumber, o1.orderNumber, o1.status) t1)
ORDER BY orderAmount DESC;
