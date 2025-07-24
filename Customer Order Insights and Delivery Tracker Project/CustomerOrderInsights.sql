create database coidb;
use coidb;

create table customers (
    customer_id int primary key,
    name varchar(100),
    email varchar(100),
    city varchar(50)
);


create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    delivery_date date,
    foreign key (customer_id) references customers(customer_id)
);

-- delivery status table
create table delivery_status (
    delivery_id int primary key,
    order_id int,
    status varchar(50),
    expected_delivery date,
    actual_delivery date,
    foreign key (order_id) references orders(order_id)
);

-- insert
insert into customers values (201, 'Ms dhoni', 'msd@g.com', 'Jharkand');
insert into customers values (202, 'V kohli', 'vk@g.com', 'bangalore');
insert into orders values (1, 201, '2024-08-01', '2024-08-05');
insert into orders values (2, 202, '2024-08-02', '2024-08-06');
insert into delivery_status values (1, 1, 'delivered', '2024-08-05', '2024-08-07');
insert into delivery_status values (2, 2, 'in transit', '2024-08-06', null);

-- read
select * from orders;
select * from customers;

-- update
update orders set delivery_date = '2024-08-07' where order_id = 1;

-- delete
delete from orders where order_id = 1;
delete from customers where customer_id = 201;

-- creating a stored procedure to fetch all delayed deliveries
delimiter $$

create procedure getdelayeddeliveries(in cid int)
begin
    select o.order_id, o.order_date, ds.actual_delivery, ds.expected_delivery
    from orders o
    join delivery_status ds on o.order_id = ds.order_id
    where o.customer_id = cid
      and ds.actual_delivery > ds.expected_delivery;
end $$

delimiter ;
