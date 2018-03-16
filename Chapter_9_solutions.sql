USE my_drum_shop;
/* Agata Jelen */

/*Write a SELECT statement that returns these columns from the Products table:
The list_price column
The discount_percent column
A column named discount_amount that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result so it has 2 decimal digits.
*/
SELECT 
    list_price,
    discount_percent,
    ROUND(list_price * (discount_percent / 100), 2) AS discount_amount
FROM
    products;
    
    
/*2.Write a SELECT statement that returns these columns from the Orders table:
The order_date column
A column that uses the DATE_FORMAT function to return the four-digit year that's stored in the order_date column (e.g., 2015)
A column that uses the DATE_FORMAT function to return the order_date column in this format: Mon-DD-YYYY (e.g., Mar-28-2015).  In other words, use abbreviated months and separate each date component with dashes.
A column that uses the DATE_FORMAT function to return the order_date column with only the hours and minutes on a 12-hour clock with an am/pm indicator (e.g., 09:40 AM).
A column that uses the DATE_FORMAT function to return the order_date column in this format: MM/DD/YY HH:mm. In other words, use two-digit months, days, and years and separate them by slashes. Use 2-digit hours and minutes on a 24-hour clock.  And use leading zeros for all date/time components (e.g., 03/30/15 15:22).

*/
SELECT 
    order_date,
    DATE_FORMAT(order_date, '%Y') AS '%Y',
    DATE_FORMAT(order_date, '%b-%d-%Y') AS '%b-%d-%Y',
    DATE_FORMAT(order_date, '%h:%i %p') AS '%h:%i %p',
    -- DATE_FORMAT(order_date, '%l:%i %p') AS '%l:%i %p' AS Time,
    DATE_FORMAT(order_date, '%m/%d/%y %H:%i') AS '%m/%d/%y %H:%i'
FROM
    orders;
    
    /* 3. Write a SELECT statement that returns these columns from the Products and Orders table:
The product_name column
The card_number column
The length of the card_number column
The last four digits of the card_number column
When you get that working right, add the following columns to the result set. This is more difficult because these columns require the use of functions within functions.
A column that displays the last four digits of the card_number column in this format: XXXX-XXXX-XXXX-1234. In other words, use Xs for the first 12 digits of the card number and actual numbers for the last four digits of the number.
A column that returns the third word in the product_name in the products table. If there is no third word, it should return an empty string. You can do this using IF and SUBSTRING_INDEX. Hint, this is complicated, the idea is that you write expression2 using SUBSTRING_INDEX that will return the 1st word if there is only one word, or the 2nd word if there are 2 words. Write expression3 using SUBSTRING_INDEX that will return the 1st word if there is only one word, or the 2nd word if there are 2 words and the 3rd word if there are three words. Then combine expression2 and expression3 with if as follows:  
IF ( expression2 != expresion3 ,  expression3, '') AS third_name
Order by product_name. */

SELECT 
    p.product_name,
    o.card_number,
    LENGTH(o.card_number) AS card_length,
    RIGHT(o.card_number, 4) AS last_four_digits,
    CONCAT('XXXX-XXXX-XXXX-', RIGHT(o.card_number, 4)) as XXXX_last_four,
    IF(LOCATE(' ',SUBSTRING(p.product_name,LOCATE(' ', p.product_name) + 1)) != 0,
        SUBSTRING_INDEX(SUBSTRING_INDEX(p.product_name, ' ', 3),' ',- 1),
        '') AS third_name
FROM
    orders o
        JOIN
    order_items oi ON o.order_id = oi.order_id
        JOIN
    products p ON oi.product_id = p.product_id
ORDER BY p.product_name;
    
    /*4. Write a SELECT statement that returns these columns from the Orders table:
The order_id column
The order_date column in format yyyy-mm-dd
A column named approx_ship_date that's calculated by adding 2 days to the order_date column in format yyyy-mm-dd
The ship_date column 
A column named days_to_ship that shows the number of days between the order date and the ship date
When you have this working, add a WHERE clause that retrieves just the orders for March 2015. 

*/

SELECT 
    order_id,
    DATE_FORMAT(order_date, '%Y-%m-%d') AS order_date,
    DATE_FORMAT(DATE_ADD(order_date, INTERVAL 2 DAY),
            '%Y-%m-%d') AS 'approx_ship_date',
    ship_date,
    DATEDIFF(ship_date, order_date) AS 'days_to_ship'
FROM
    orders
WHERE
    EXTRACT(MONTH FROM order_date) = 3 AND EXTRACT(YEAR FROM order_date) = 2015;
    -- MONTH(order_date) = 3 AND YEAR(order_date) = 2015;


/********************My nots to check tables SELECT
*
FROM
orders; *********************************/