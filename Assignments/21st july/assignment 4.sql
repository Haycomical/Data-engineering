create database assignment4;
use assignment4;
Create table movies (
	movie_id int primary key,
    title varchar(100),
    genre varchar(100),
    release_year date,
    rental_rate decimal(10,2)
);

Create table customers(
	customer_id int primary key,
    name varchar(100),
    email varchar(100),
    city varchar(50)
);

Create table rentals (
    rental_id int primary key,
    customer_id int,
    movie_id int,
    rental_date date,
    return_date date,
    foreign key (customer_id) references customers(customer_id),
    foreign key (movie_id) references movies(movie_id)
);

insert into  movies values
(1, "Fury", "war", '2015-03-31', 3.99),
(2, "gattaca", "sci-fi", '1997-07-16', 4.50),
(3, "Seven", "crime", '1997-10-14', 2.99),
(4, "Sicario", "action", '2018-07-18', 4.25),
(5, "incendies", "drama", '2010-07-06', 3.50);

insert into customers  values
(1, "vikram singh", "vikram@gmail.com", "punjab"),
(2, "sridevi sharma", "sd@gmail.com", "mumbai"),
(3, "rahul dravid", "rahul@gmail.com", "delhi"),
(4, "pawan kalyan", "pawan@gmail.com", "hyderabad"),
(5, "ashwin", "ashwin@gmail.com", "chennai");

insert into rentals values
(1, 1, 1, '2023-06-10', '2023-06-12'),
(2, 1, 3, '2023-07-01', '2023-07-03'),
(3, 2, 2, '2023-06-15', '2023-06-18'),
(4, 3, 4, '2023-06-20', '2023-06-23'),
(5, 3, 5, '2023-07-05', NULL),
(6, 2, 1, '2023-07-10', '2023-07-13'),
(7, 4, 3, '2023-07-11', '2023-07-13'),
(8, 1, 5, '2023-07-15', NULL);

-- 1
select m.title from rentals r join  customers c on r.customer_id=c.customer_id join movies m on r.movie_id=m.movie_id where c.name="amit sharma";
update customers set name="amit sharma" where customer_id=1;

-- 2
select * from customers where city ='Bangalore'; 

-- 3 
select * from movies where release_year>2020;

-- 4 
select name, count(*) as total from rentals r join  customers c on r.customer_id=c.customer_id
join movies m on r.movie_id = m.movie_id group by name;

-- 5
select m.title, count(r.rental_id) as total from movies m join rentals r on m.movie_id=r.movie_id group by m.movie_id order by total desc limit 1;

-- 6 
select sum(m.rental_rate) as total from rentals r join movies m on r.movie_id=m.movie_id;

-- 7 
select c.name from customers c left join rentals r on c.customer_id = r.customer_id where r.rental_id is null;

-- 8
select m.genre, sum(m.rental_rate) as revenue from rentals r join movies m on r.movie_id=m.movie_id group by m.genre;

-- 9
select c.name, SUM(m.rental_rate) as total_spent from rentals r join customers c on r.customer_id = c.customer_id
join movies m on r.movie_id = m.movie_id group by c.customer_id order by total_spent desc limit 1;

-- 10
select distinct m.title from rentals r join movies m on r.movie_id=m.movie_id where r.return_date is null;

