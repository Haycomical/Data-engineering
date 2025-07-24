
use assessdb;
create table destinations (
  destination_id int primary key,
  city varchar(50),
  country varchar(50),
  category varchar(30),
  avg_cost_per_day int
);

create table trips (
  trip_id int primary key,
  destination_id int,
  traveler_name varchar(50),
  start_date date,
  end_date date,
  budget int,
  foreign key (destination_id) references destinations(destination_id)
);

-- insert values into tables 
-- insert values into tables 
insert into destinations values
(1, "barcelona-Catalunya", "spain", "race tarck", 3200),
(2, "de-monaco", "italy", "historical", 4200),
(3, "spa-franscorchamps", "canada", "nature", 2700),
(4, "las vegas", "united states of america", "adventure", 3800),
(5, "silverstone", "britain", "cultural", 3100),
(6, "suzuka", "Japan", "beach", 2600);

insert into trips values
(101, 1, "max", "2025-04-02", "2025-04-08", 25000),
(102, 2, "lewis", "2023-09-12", "2023-09-18", 28000),
(103, 3, "oscar", "2025-06-01", "2025-06-10", 36000),
(104, 4, "lando", "2022-12-20", "2022-12-28", 30000),
(105, 5, "fernando", "2023-10-05", "2023-10-12", 34000),
(106, 6, "carlos", "2023-02-15", "2023-02-20", 18000),
(107, 1, "alex", "2025-07-10", "2025-07-15", 26000),
(108, 2, "kimi", "2024-08-01", "2024-08-08", 35000),
(109, 3, "piere", "2025-03-15", "2025-03-20", 21000),
(110, 6, "nico", "2024-11-05", "2024-11-12", 20000);


-- 1
select t.* from trips t join destinations d on t.destination_id = d.destination_id where d.country = "india";

-- 2
select * from destinations where avg_cost_per_day < 3000;

-- 3
select trip_id, traveler_name, datediff(end_date, start_date) + 1 as duration_days from trips;

-- 4 
select * from trips where datediff(end_date, start_date) + 1 > 7;

-- 5 
select t.traveler_name, d.city,(datediff(t.end_date, t.start_date) + 1) * d.avg_cost_per_day as total_cost 
from trips t
join destinations d on t.destination_id = d.destination_id;

-- 6 
select d.country, count(*) as total_trips from trips t
join destinations d on t.destination_id = d.destination_id
group by d.country;

-- grouping and filtering 
-- 7 
select d.country, avg(t.budget) as avg_budget from trips t
join destinations d on t.destination_id = d.destination_id
group by d.country;

-- 8 
select traveler_name, count(*) as trip_count from trips
group by traveler_name
order by trip_count desc
limit 1;

-- 9 
select * from destinations where destination_id not in (select distinct destination_id from trips);

-- 10 
select t.*, t.budget / (datediff(t.end_date, t.start_date) + 1) as cost_per_day from trips t
order by cost_per_day desc
limit 1;

-- 11 
update trips set end_date = date_add(end_date, interval 3 day), 
budget = budget + (select avg_cost_per_day from destinations where destination_id = trips.destination_id) * 3
where trip_id = 101;

-- 12
delete from trips where end_date < "2023-01-01";
