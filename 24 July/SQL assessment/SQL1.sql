
create database assessdb;
use assessdb;


create table exercises (
  exercise_id int primary key,
  exercise_name varchar(50),
  category varchar(20),
  calories_burn_per_min int
);

create table workoutlog (
  log_id int primary key,
  exercise_id int,
  date date,
  duration_min int,
  mood varchar(20),
  foreign key (exercise_id) references exercises(exercise_id)
);
insert into exercises values
(1, "jogging", "cardio", 9),
(2, "pilates", "flexibility", 5),
(3, "rowing", "cardio", 12),
(4, "push-ups", "strength", 7),
(5, "zumba", "cardio", 10);

insert into workoutlog values
(1, 1, "2025-03-01", 25, "energized"),
(2, 2, "2025-03-02", 50, "normal"),
(3, 3, "2025-03-03", 40, "tired"),
(4, 4, "2025-03-04", 30, "energized"),
(5, 5, "2025-03-05", 45, "normal"),
(6, 1, "2025-03-07", 35, "tired"),
(7, 2, "2025-03-08", 55, "energized"),
(8, 3, "2025-03-09", 60, "tired"),
(9, 4, "2025-03-10", 20, "normal"),
(10, 5, "2025-03-11", 50, "energized");



-- 1
select * from exercises where category = "cardio";

-- 2 
select * from workoutlog where month(date)=3 and year(date)=2025;

-- 3 
select w.log_id, e.exercise_id, w.duration_min, e.calories_burn_per_min * w.duration_min as calorie_burned from workoutlog w
join exercises e on e.exercise_id = w.exercise_id;

-- 4
select e.category, avg(w.duration_min) from workoutlog w join exercises e on e.exercise_id = w.exercise_id
group by e.category;


-- 5 
select e.exercise_name, w.date, w.duration_min, e.calories_burn_per_min * w.duration_min as calories_burned from exercises e 
join workoutlog w on e.exercise_id = w.exercise_id;

-- 6
select w.date, sum(w.duration_min * e.calories_burn_per_min) as total_calories from workoutlog w
join exercises e on w.exercise_id = e.exercise_id
group by w.date;


-- 7 
select e.exercise_name, sum(w.duration_min * e.calories_burn_per_min) as total_calories from workoutlog w 
join exercises e on w.exercise_id = e.exercise_id
group by e.exercise_name
order by total_calories desc
limit 1;

-- 8
select * from exercises where exercise_id not in (select distinct exercise_id from workoutlog);

-- 9 
select * from workoutlog where mood = 'Tired' and duration_min > 30;

-- 10
update workoutlog set mood = 'Energized' where log_id = 2;

-- 11
update exercises set calories_burn_per_min = 12 where exercise_name = 'Running';

-- 12
delete from workoutlog where month(date) = 2 and year(date) = 2024;