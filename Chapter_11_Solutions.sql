/* Chapter 11 Solusions
Homework, checked, errors fixed 
Agata Jelen CSD 138 */


USE my_drum_shop;

/* 
1.  
Write a script that adds an index to the my_drum_shop database for the zip code field in the addresses table.
*/
CREATE INDEX addresses_zip_code_ix ON addresses (zip_code);

/* 
2. 
Write a script that implements the following design in a database named my_web_db:
*/

DROP DATABASE IF EXISTS my_web_db;
CREATE DATABASE my_web_db CHARSET utf8;
USE my_web_db;

DROP TABLE IF EXISTS downloads;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
user_id       INT          PRIMARY KEY	AUTO_INCREMENT,
email_address VARCHAR(100) NOT NULL,
first_name    VARCHAR(45)  NOT NULL,
last_name     VARCHAR(45)  NOT NULL
) ENGINE = InnoDB;

CREATE TABLE products
(
product_id    INT          PRIMARY KEY  AUTO_INCREMENT,
product_name  VARCHAR(45)  NOT NULL
) ENGINE = InnoDB;

CREATE TABLE downloads
(
download_id   INT          PRIMARY KEY  AUTO_INCREMENT,
user_id	      INT,
download_date DATETIME,
filename      VARCHAR(50),
product_id    INT,
CONSTRAINT downloads_fk_products foreign key(product_id) 
            REFERENCES products (product_id),
CONSTRAINT downloads_fk_users foreign key(user_id)
            REFERENCES users (user_id)
) ENGINE = InnoDB;

/* 
3. Write a script that adds rows to the database that you created in exercise 2.
Add two rows to the Users and Products tables.
Add three rows to the Downloads table: one row for user 1 and product 2; 
one row for user 2 and product 1; and one row for user 2 and product 2. 
Use the NOW function to insert the current date and time into the download_date column. 
 */
use my_web_db;

INSERT INTO users
(user_id, email_address, first_name, last_name)
VALUES
(1, 'user2@gmail.com', 'Dick', 'Green'),
(2, 'user1@gmail.com', 'Tom', 'Brown');

INSERT INTO products
(product_id, product_name)
VALUES
(1, 'pen'),
(2, 'pencil');

INSERT INTO downloads
(download_id, user_id, download_date, filename, product_id)
VALUES
(default, 1, now(), 'filename1', 2),
(default, 2, now(), 'filename2', 1),
(default, 2, now(), 'filename3', 2);

/* 4. Write a SELECT statement that joins the three tables and retrieves the product_name, first_name, last_name. 
Sort by product_name, last_name, first_name. */
SELECT 
    product_name, first_name, last_name
FROM
    users u
        JOIN
    downloads d ON u.user_id = d.user_id
        JOIN
    products p ON p.product_id = d.product_id
ORDER BY product_name , last_name , first_name;

/* 5. Write an ALTER TABLE statement that adds two new columns to the Products table created in exercise 2.  
Add one column for product price that provides for three digits to the left of the decimal point and two to the right. 
This column should have a default value of 9.99.
Add one column for the date and time that the product was added to the database. 
*/
ALTER TABLE products
ADD   column product_price decimal(5,2) DEFAULT 9.99,
ADD column payment_date_and_time DATETIME;

/*6. Write an ALTER TABLE statement that modifies the Users table created in exercise 2 so the first_name column cannot store NULL values and can store a maximum of 20 characters.
Code an UPDATE statement that attempts to insert a NULL value into this column. It should fail due to the NOT NULL constraint.
Code another UPDATE statement that attempts to insert a first name that's longer than 20 characters. It should fail.
*/
ALTER TABLE users
MODIFY first_name VARCHAR(20) NOT NULL;

UPDATE users 
SET 
    first_name = NULL
WHERE
    user_id = 1;
    
UPDATE users 
SET 
    first_name = 'long_first_name_greater_than_20_characters'
    -- first_name = 'short_first_name'
WHERE
    user_id = 1;
