create database assignment3;
use assignment3;
create table books(
	book_id int primary key,
    title varchar(100),
    author varchar(100),
    genre varchar(50),
    price decimal(10,2));

create table customers(
	customer_id int primary key,
    name varchar(100),
    email varchar(100),
    city varchar(100));

create table orders(
order_id int primary key,
customer_id int,
book_id int,
order_date date,
quantity int,
foreign key (customer_id) references customers(customer_id),
foreign key (book_id) references books(book_id));

insert into books values
(1, "the indian polity", "m.laxmikanth", "polity", 600.00),
(2, "psycology of money", "morgan", "self-help", 550.00),
(3, "the astronomy", "neil degrase", "science", 400.00),
(4, "thirukural", "thiruvalluvar", "literature", 700.00),
(5, "sapiens and homo deus", "yuval noah", "history", 500.00);


insert into customers  values
(1, "vikram singh", "vikram@gmail.com", "punjab"),
(2, "sridevi sharma", "sd@gmail.com", "mumbai"),
(3, "rahul dravid", "rahul@gmail.com", "delhi"),
(4, "pawan kalyan", "pawan@gmail.com", "hyderabad"),
(5, "ashwin", "ashwin@gmail.com", "chennai");

insert into orders values
(1001, 1, 3, "2023-01-15", 1),
(1002, 2, 1, "2023-02-20", 2),
(1003, 1, 5, "2023-03-10", 1),
(1004, 3, 2, "2023-04-05", 1),
(1005, 4, 4, "2023-05-01", 1),
(1006, 2, 3, "2023-06-12", 1),
(1007, 5, 1, "2023-07-01", 3),
(1008, 1, 2, "2023-07-10", 1);


-- 1
select * from books where price>500;

-- 2
select * from customers where city ="Hyderabad";

-- 3
select * from orders where order_date<"2023-01-01"; 

-- 4
select c.name,b.title from customers c join orders o on o.customer_id=c.customer_id
join books b on o.book_id=b.book_id ;

-- 5
select b.genre,sum(o.quantity) from orders o join books b on o.book_id=b.book_id group by b.genre; 

-- 6
select b.title,sum(b.price * o.quantity) from orders o join books b on o.book_id=b.book_id group by b.title;

-- 7
select c.name, count(*) from orders o left join customers c on o.customer_id=c.customer_id group by c.name order by count(*) desc limit 1;

-- 8
select genre, avg(price) from books group by genre;

-- 9
select b.title from books b left join orders o on b.book_id=o.book_id where o.book_id is null;
insert into books values(6, "lec on physics", "feyman", "physics", 600.00);

-- 10
select c.name, sum(b.price*o.quantity)as total from orders o join customers c on o.customer_id = c.customer_id
join books b on o.book_id = b.book_id group by c.name order by total desc limit 1;