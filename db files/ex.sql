show databases;
use hexaairlines;

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2),
  stock_quantity INT,
  added_date DATE
);


INSERT INTO products VALUES
(1, 'Mouse', 'Electronics', 950.00, 20, '2023-03-10'),
(2, 'Chair', 'Furniture', 7500.00, 5, '2024-08-15'),
(3, 'Shoes', 'Footwear', 1800.00, 12, '2023-11-21'),
(4, 'Cooker', 'Kitchenware', 2200.00, 8, '2024-02-07'),
(5, 'Pants', 'Fashion', 1200.00, 0, '2023-05-01');


SELECT * FROM products; 
SELECT product_name, price FROM products; 
SELECT * FROM products WHERE stock_quantity < 10; 
SELECT * FROM products WHERE price BETWEEN 500 AND 2000; 
SELECT * FROM products WHERE added_date > '2023-01-01'; 
SELECT * FROM products WHERE product_name LIKE 'S%'; 
SELECT * FROM products WHERE category IN ('Electronics', 'Furniture'); 


UPDATE products SET price = 990 WHERE product_id = 1; 
UPDATE products SET stock_quantity = stock_quantity + 5 WHERE category = 'Furniture'; 
DELETE FROM products WHERE product_id = 5;
DELETE FROM products WHERE stock_quantity = 0; 