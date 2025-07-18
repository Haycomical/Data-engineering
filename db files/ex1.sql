/*
CREATE DATABASE analytics_practice;
USE analytics_practice;
 
CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    region VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);
 
INSERT INTO sales_data VALUES
(1, 'Amit Sharma', 'North', 12000.50, '2024-01-15'),
(2, 'Neha Reddy', 'East', 8500.00, '2024-01-16'),
(3, 'Faizan Ali', 'North', 10000.00, '2024-01-20'),
(4, 'Divya Iyer', 'South', 13000.00, '2024-01-21'),
(5, 'Kiran Mehta', 'East', 9000.00, '2024-01-22'),
(6, 'Amit Sharma', 'North', 15000.00, '2024-02-05'),
(7, 'Neha Reddy', 'East', 8000.00, '2024-02-10'),
(8, 'Faizan Ali', 'North', 7000.00, '2024-02-15'),
(9, 'Divya Iyer', 'South', 14000.00, '2024-02-18'),
(10, 'Kiran Mehta', 'East', 6500.00, '2024-02-20');
*/



/*
CREATE DATABASE simple_sql;
USE simple_sql;
 
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    age INT
);
 
INSERT INTO employees VALUES
(1, 'Amit', 'HR', 30000, 25),
(2, 'Neha', 'IT', 45000, 28),
(3, 'Rahul', 'IT', 50000, 30),
(4, 'Divya', 'Sales', 40000, 26),
(5, 'Kiran', 'Sales', 35000, 24),
(6, 'Meena', 'HR', 32000, 29);

SELECT dept_avg . department, dept_avg.avg_salary
FROM (
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
) AS dept_avg;

SELECT emp_name, department, salary,
rank() over (order by salary desc) AS salary_rank
FROM employees;
*/
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
 
 
INSERT INTO customers VALUES
(1, 'Amit Sharma', 'Delhi'),
(2, 'Neha Reddy', 'Hyderabad'),
(3, 'Rahul Iyer', 'Mumbai'),
(4, 'Divya Mehta', 'Chennai');
 
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    order_amount INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
 
INSERT INTO orders VALUES
(101, 1, 'Laptop', 55000),
(102, 2, 'Mouse', 500),
(103, 1, 'Keyboard', 1500),
(104, 3, 'Monitor', 7000),
(105, 2, 'Printer', 8500);

#buyers info
SELECT customers.customer_name, orders.product_name,
orders.order_amount
FROM customers
INNER JOIN orders
ON customers.customer_id = orders. customer_id;


#Promotion from company , registered but not placed orders yet.
SELECT customers.customer_name, orders.product_name 
FROM customers
LEFT JOIN orders
ON customers.customer_id= orders.customer_id;


SELECT o.order_id,c.customer_name,c.city,o.product_name ,o.order_amount
FROM orders o
JOIN customers c
ON o. customer_id= c. customer_id;

SELECT c.customer_name, count(o.order_id)AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING total_orders > 1;
