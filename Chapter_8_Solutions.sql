/* Chapter 8 solutions 
Agata Jelen CSD 138 */


use my_drum_shop;

/* 
1.	Write a SELECT statement that returns these columns from the Products table:
The list_price column
A column that uses the FORMAT function to return the list_price column with 1 digit to the right of the decimal point
A column that uses the CONVERT function to return the list_price column as an integer
A column that uses the CAST function to return the list_price column as an integer
 */
SELECT 
    list_price,
    FORMAT(list_price, 1),
    CONVERT( list_price , UNSIGNED), -- could also use signed
    CAST(list_price AS UNSIGNED)     -- could also use signed
FROM
    products;


/* 
2.	Write a SELECT statement that returns these columns from the Products table:
The date_added column
A column that uses the CAST function to return the date_added column with its date only (year, month, and day)
A column that uses the CAST function to return the date_added column with just the year and the month
A column that uses the CAST function to return the date_added column with its full time only (hour, minutes, and seconds)
*/
SELECT 
    date_added,
    CAST(date_added as date),
    -- CAST(date_added AS CHAR (10)),  alternative solution
    CAST(date_added AS CHAR (7)),
    CAST(date_added AS TIME)
FROM
    products;
