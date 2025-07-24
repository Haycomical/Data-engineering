create database scdb;
use scdb;

-- create suppliers table
create table suppliers (
    supplier_id int primary key,
    supplier_name varchar(100),
    contact_email varchar(100)
);

-- create inventory table
create table inventory (
    item_id int primary key,
    item_name varchar(100),
    stock_quantity int,
    reorder_level int
);

-- create orders table
create table orders (
    order_id int primary key,
    item_id int,
    supplier_id int,
    quantity_ordered int,
    order_date date,
    delivery_date date,
    foreign key (item_id) references inventory(item_id),
    foreign key (supplier_id) references suppliers(supplier_id)
);

-- insert
insert into suppliers values (1, 'NO1 corp', 'one@g.com');
insert into suppliers values (2, 'NO2 corp', 'two@g.com');

insert into inventory values (101, 'steel rods', 50, 20);
insert into inventory values (102, 'copper wires', 15, 10);

insert into orders values (201, 101, 1, 30, '2025-07-20', '2025-07-23');
insert into orders values (202, 102, 2, 10, '2025-07-21', '2025-07-24');

-- read
select * from orders;

-- update
update inventory set stock_quantity = stock_quantity - 30 where item_id = 101;

-- delete
delete from orders where order_id = 201;

-- auto reorder stored procedure
delimiter $$

create procedure autoreorder()
begin
    declare done int default 0;
    declare v_item_id int;
    declare v_stock int;
    declare v_reorder int;
    declare cur cursor for select item_id, stock_quantity, reorder_level from inventory;
    declare continue handler for not found set done = 1;

    open cur;
    read_loop: loop
        fetch cur into v_item_id, v_stock, v_reorder;
        if done then
            leave read_loop;
        end if;
        if v_stock <= v_reorder then
            insert into orders (item_id, supplier_id, quantity_ordered, order_date, delivery_date)
            values (v_item_id, 1, 50, curdate(), date_add(curdate(), interval 3 day));
        end if;
    end loop;
    close cur;
end$$

delimiter ;
