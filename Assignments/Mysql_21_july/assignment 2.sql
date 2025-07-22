create database assignment2;
use assignment2;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    department_id INT
);


INSERT INTO students VALUES
(1, 'Amit Sharma', 20, 'Male', 1),
(2, 'Neha Reddy', 22, 'Female', 2),
(3, 'Faizan Ali', 21, 'Male', 1),
(4, 'Divya Mehta', 23, 'Female', 3),
(5, 'Ravi Verma', 22, 'Male', 2);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    head_of_department VARCHAR(100)
);


INSERT INTO departments VALUES
(1, 'Computer Science', 'Dr. Rao'),
(2, 'Electronics', 'Dr. Iyer'),
(3, 'Mechanical', 'Dr. Khan');


CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department_id INT,
    credit_hours INT
);


INSERT INTO courses VALUES
(101, 'Data Structures', 1, 4),
(102, 'Circuits', 2, 3),
(103, 'Thermodynamics', 3, 4),
(104, 'Algorithms', 1, 3),
(105, 'Microcontrollers', 2, 2);


-- 1
select name,age ,gender from students;

-- 2
select * from students where gender="Female";

-- 3
select c.course_name from courses c join departments d on c.department_id=d.department_id where d.department_name = "Electronics";

-- 4
select * from departments where department_id=1;

-- 5 
select * from students where age >21;

-- 6
select s.name,d.department_name from students s join departments d on s.department_id=d.department_id;

-- 7
select d.department_name , count(*) from students s join departments d on d.department_id=s.department_id group by d.department_name;

-- 9
select d.department_name, c.course_name from courses c join departments d on c.department_id=d.department_id;

-- 8
select d.department_name,avg(s.age) from students s join departments d on d.department_id=s.department_id group by d.department_id; 

-- 10
insert into departments values (4,"AI&DS", "Dr.doom");
select s.name,d.department_name from students s right join departments d on s.department_id=d.department_id where s.student_id is null; 

-- 11
select d.department_name, count(c.course_id) from courses c join departments d on c.department_id=d.department_id group by d.department_name order by count(course_id) desc limit 1;

-- 12

select * from students where age>(select avg(age) from students);

-- 13
select d.department_name,c.course_name from departments d join courses c on c.department_id=d.department_id where c.credit_hours>3;

-- 14
select  s.name from students s  where department_id=(select department_id from courses group by department_id  order by count(*) asc limit 1 );

-- 15
select s.name from students s join departments d on d.department_id=s.department_id where d.head_of_department like "Dr.%";

-- 16
select * from students order by age desc limit 1 offset 1;

-- 17
select c.course_name from courses c join departments d on c.department_id=d.department_id where d.department_id in (select department_id from students group by department_id having count(student_id)>2);
insert into students values (106,"jo",20,"male",1);

