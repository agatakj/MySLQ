/* Chapter 12 solutions 
Agata Jelen CSD 138 all fixed */


use my_drum_shop;

/* 1.Create a view named customer_addresses that shows the shipping and billing addresses for each customer.
This view should return these columns from the Customers table: customer_id, email_address, last_name and first_name.
This view should return these columns from the Addresses table: bill_line1, bill_line2, bill_city, bill_state, bill_zip, ship_line1, ship_line2, ship_city, ship_state, and ship_zip.
*/
CREATE OR REPLACE VIEW customer_addresses AS
    SELECT 
    c.customer_id,
    email_address,
    last_name,
    first_name,
    ba.line1 AS bill_line1,
    ba.line2 AS bill_line2,
    ba.city AS bill_city,
    ba.state AS bill_state,
    ba.zip_code AS bill_zip,
    sa.line1 AS ship_line1,
    sa.line2 AS ship_line2,
    sa.city AS ship_city,
    sa.state AS ship_state,
    sa.zip_code AS ship_zip
FROM
    customers c
        JOIN
    addresses ba ON c.customer_id = ba.customer_id
        AND c.billing_address_id = ba.address_id
        JOIN
    addresses sa ON c.customer_id = sa.customer_id
        AND c.shipping_address_id = sa.address_id;

/* 
2
Write a SELECT statement that returns these columns from the customer_addresses 
view that you created in exercise 1: customer_id, last_name, first_name, bill_line1.*/
SELECT 
    customer_id, last_name, first_name, bill_line1
FROM
    customer_addresses;

/*
3 
Write an UPDATE statement that updates the Customers table using the customer_addresses view you created in exercise 1. 
Set the first line of the shipping address to "1990 Westwood Blvd." for the customer with an ID of 8.*/
UPDATE customer_addresses
SET
    ship_line1 = '1990 Westwood Blvd'
WHERE
    customer_id = 8;

/*
4 Create a view named order_item_products that returns columns from the Orders, Order_Items, and Products tables.
This view should return these columns from the Orders table: order_id, order_date, tax_amount, and ship_date.
This view should return these columns from the Order_Items table: item_price, discount_amount, final_price (the discount amount subtracted from the item price), quantity, and item_total (the calculated total for the item).
*/
CREATE OR REPLACE VIEW order_item_products AS
    SELECT 
        o.order_id,
        order_date,
        tax_amount,
        ship_date,
        item_price,
        discount_amount,
        (item_price - discount_amount) AS final_price,
        quantity,
        (item_price - discount_amount) * quantity AS item_total,
        product_name
    FROM
        orders o
            JOIN
        order_items oi ON o.order_id = oi.order_id
            JOIN
        products p ON oi.product_id = p.product_id;
		 
/*
5 
Create a view named product_summary that uses the view you created in exercise 4. This view should return summary information about each product.
Each row should include product_name, order_count (the number of times the product has been ordered) and order_total (the total sales for the product).
*/
CREATE OR REPLACE VIEW product_summary AS
    SELECT 
        product_name,
        SUM(quantity) AS order_count,
        SUM(item_total) AS order_total
    FROM
        order_item_products
    GROUP BY product_name;

/*6
Write a SELECT statement that uses the view that you created in exercise 5 to get the sum of the order_total 
for the five best selling products.
*/
SELECT 
    SUM(order_total)
FROM
    (SELECT 
        order_total
    FROM
        product_summary
    ORDER BY order_total DESC
    LIMIT 5) t;
