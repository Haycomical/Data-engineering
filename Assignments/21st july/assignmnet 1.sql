create database assignment1;
use assignment1;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    age INT
);


INSERT INTO employees VALUES
(101, 'Amit Sharma', 'Engineering', 60000, 30),
(102, 'Neha Reddy', 'Marketing', 45000, 28),
(103, 'Faizan Ali', 'Engineering', 58000, 32),
(104, 'Divya Mehta', 'HR', 40000, 29),
(105, 'Ravi Verma', 'Sales', 35000, 26);


CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);


INSERT INTO departments VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'Marketing', 'Mumbai'),
(3, 'HR', 'Delhi'),
(4, 'Sales', 'Chennai');


-- 1
select * from employees;

-- 2
select emp_name , salary from employees;

-- 3
select * from employees where salary>40000;

-- 4
select * from employees where age between 28 and 32;

-- 5
select * from employees where department != "HR";

-- 6
select * from employees order by salary desc;

-- 7
select count(*) from employees ;

-- 8
select *  from  employees order by salary desc limit 1 ;
-- section B
-- 1
select e.emp_name,d.location from employees e join departments d on e.department=d.dept_name;

-- 2
select department,count(*)from employees group by department;

-- 3
select department,avg(salary) from employees group by department;

-- 4
select d.dept_name from departments d left join employees e on e.department=d.dept_name where e.emp_id is null;
insert into departments values(5,"data enginnering","Noida"); 
delete  from departments where dept_id=5;
select * from departments;

-- 5
select department , sum(salary) from employees group by department;

-- 6
select department ,avg(salary) from employees  group by department having avg(salary)> 45000;

-- 7
select emp_name,department from employees where salary>50000;
