create database assignments;
use assignments;
CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100)
);

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(100),
  dept_id INT,
  salary INT
);
INSERT INTO departments VALUES
  (1, 'Resources'),
  (2, 'Engineering'),
  (3, 'Marketing');

INSERT INTO employees VALUES
  (101, 'Amit Sharma', 1, 30000),
  (102, 'Neha Reddy', 2, 45000),
  (103, 'Faizan Ali', 2, 48800),
  (104, 'Diwa Mehta', 3, 35000),
  (105, 'Ravi Verma', NULL, 28000);
  
select e.emp_id,e.emp_name,dept_name
from employees e
join departments d on e.dept_id=d.dept_id;

select * from employees where dept_id is null;

select d.dept_name,count(e.emp_id) as total_count
from  departments d
left join employees e on e.dept_id=d.dept_id
group by dept_name;

SELECT dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 40000;
