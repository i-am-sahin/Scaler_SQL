-- Session 2 : Keys Lab Session : 
-- Create Database for School:

create database school;

-- Create some tables for school database

-- To use the particular Database We've to select the database first
use school;

-- Create batches table
create table batch(
batch_id int primary key,
batch_name varchar(50)
);

desc  batch; -- It gives description of the tables.

-- Inserting some dummy data in batches table:
insert into batch(batch_id,batch_name) values
(1,'A'),
(2,'B'),
(3,'C'),
(4,'D');

-- Create Students table
create table students(
student_id int auto_increment primary key,
first_name varchar(50) not null,
last_name varchar(50),
branch_id int,
foreign key(branch_id) references batch(batch_id)
-- FOREIGN KEY(batch_id) references batches(batch_id)
);

-- Inserting some dummy data in students:
insert into students(first_name,last_name,branch_id) values
('Sahin','Islam',1),
('Sayak','Mondal',2),
('Jim', 'Brown', 1),
('Jack', 'Johnson', 3),
('Christiano', 'Messi', 1);


-- Some eureka moments:

-- we can't update parent table's referance column if that is been used.
update batch 
set batch_id = 50
where batch_id = 2;
-- 23:32:52	update batch  set batch_id = 50 where batch_id = 2	Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`school`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `batch` (`batch_id`))	0.0047 sec

update batch 
set batch_id = 50
where batch_id = 4;

-- We can't update Primary key 

update batch
set batch_id = 2
where batch_id = 4;
-- Error Code: 1062. Duplicate entry '2' for key 'batch.PRIMARY'



delete from batch
where batch_id = 2;

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`school`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `batch` (`batch_id`))



delete from batch
where batch_id = 4;


-- CRUD Class 01 : 

use sakila;

desc film;

INSERT INTO film
VALUES (default, 'Comedy movie', 'hehehe', 2022, 1, NULL, 3, 3.39, 152, 19.99, 'G', 'Trailers', default);

-- Select query : 
	-- Printing constants: 
Select 1;
select 'sahin' as name;
	-- Printing Full table: 
select * 
from film;

	-- Printing selected columns from table: 
select film_id,title
from film;

select release_year
from film;
	-- Printing Unique release Year from film table
select distinct release_year
from film;

	-- Question : gett all distinct ratings per year in films table
select distinct release_year, rating
from film;

	-- Problem Statement : Get all Movies with PG-13 rating.
    
select * from film
where rating = 'PG-13';

	-- Logical Operations
		-- Problem Statements : Get all the films which were released in 2006 and have rating PG-13.

select title, release_year, rating
 from film
where release_year = 2006 and
 rating = 'PG-13';

		-- Problem Statements : Get all the films which were released in 2006 or have rating PG-13.

select title, release_year, rating
 from film
where release_year = 2006 or
 rating = 'PG-13';


		-- Problem Statements : Get all the films which were released in 2006 and have other than rating PG-13.

select title, release_year, rating
 from film
where release_year = 2006 and
 rating != 'PG-13';

select title, release_year, rating
 from film
where release_year = 2006 and not
 rating = 'PG-13';

select title, release_year, rating
 from film
where release_year = 2006 and
 rating <> 'PG-13';


	-- Order By
		-- Problem Statement : Get all movies Sorted according to rental_duration
        
select film_id, title, rental_duration
from film
order by rental_duration;


select film_id, title, rental_duration, rental_rate
from film
order by rental_duration, rental_rate desc;


	-- In clause:
		-- Problem statement: Get all the students which belongs to either of batches: 1, 4, 5, 3, 6, 7, 8
        
use school;
select * from students
where branch_id in(1,4,5,3,6,7,8);
        
        
        
	-- Between Operator:
		-- Problem statement: Get data of all the films having rental_duration between 1 to 5:
use sakila;
select title,rental_duration
from film
where rental_duration between 1 and 5 
order by rental_duration desc;



	-- Alter
use school;    
alter table students
add psp int;
		-- Modifying table schema using alter
alter table students
modify psp varchar(50);        
        
        -- Droping table schema using alter
alter table students
drop psp ;        

	-- Update Query

update students
set last_name = 'Ronaldo'
where student_id = 5;

update students
set first_name = 'sahin' and psp = 35.00 -- Error Code: 1292. Truncated incorrect DOUBLE value: 'Ronaldo'
where student_id = 5;

update students
set first_name = 'sahin', psp = 35.00 -- right approach
where student_id = 5;


set sql_safe_updates = 0;


set sql_safe_updates = 1;

show variables like'sql_safe_updates';


	-- Delete vs Truncate vs Drop
    
    -- Delete:
    
delete from students
where student_id = 5;

	-- Truncate:
Truncate table students;

	-- Drop : 
drop table students;


-- SQL 4: CRUD 2 / Lab Session 2
    
	-- Limit and Offset

use sakila;
select * from film
limit 2
offset 99;

select * from film
order by rental_duration desc
limit 5;
		
	-- Like Keyword : 
		-- Problem Statement : Get all the movies which have love in it.

select film_id,title, description
from film
where binary title  like '%LOVE%';



	-- Working with Null
    

select 1 = 1;
select 1 = 2;

select 1 = Null;
select Null = Null;

select Null is Null;

select Null is not Null;    



	-- Concate and Round Function
    
    use school;
    select concat(first_name,' ' ,last_name) from students;
    
    
    select round(12.36652545,2);



	-- Problem 1: Identifying Popular Films
	-- The management wants to identify the first 10 distinct film titles from the film table that contain the word "Adventure"
	-- in their title (case insensitive), sorted alphabetically. Write an SQL query that returns the film titles.


use sakila;
select distinct title from film
where  title like '%Adventure%'
order by title 
limit 10;


	-- Problem 2: Tracking Unreturned Rentals
	-- The store is experiencing issues with customers not returning their rentals on time. From the rental table, list the first 5 rental IDs 
    -- where the return_date is NULL, ordered by the rental_date in descending order. Write an SQL query to fetch this data.

select rental_id from rental
where return_date is null
order by rental_id
limit 5;



	-- Problem 3: Cleaning Up Missing Data
	-- The IT department identified that some film descriptions in the film table are missing. To prepare a list for further investigation, 
    -- retrieve 15 distinct film titles with NULL descriptions, ordered by their title in ascending order. Write an SQL query to achieve this.


use sakila;


select distinct title from film
where description is null
order by title asc
limit 15;



	-- Problem 4: Filtering by Customer Names
	-- The marketing team wants to run a campaign for customers whose names start with the letter "A" or contain "Smith" anywhere in their name.
    -- From the customer table, fetch the first 10 customers (first name and last name) whose names match this criterion, sorted by last_name in alphabetical order.
    -- Write an SQL query that satisfies this requirement.

select concat(first_name, ' ', last_name) as name from customer
where first_name like 'A%' or
 first_name like '%Smith%' or
last_name like '%Smith%'
order by last_name asc
limit 10;


	-- Problem 5: Detecting Unused Inventory
	-- The management suspects that some inventory items in the inventory table might not be linked to any store.
    -- Generate a report to identify the first 10 inventory items where the store_id is NULL, 
	-- ordered by inventory_id in ascending order. Write an SQL query to provide the required information.

select * from inventory
where store_id is null
order by inventory_id asc
limit 10;



	-- Problem 6: Exploring Film Ratings
	-- To understand customer preferences, the management wants to know the distinct film ratings from the film table where special_features is NULL. 
    -- Return the ratings sorted in ascending order. Write an SQL query for this.
    use sakila;
    select distinct rating from film
    where special_features is null 
    order by rating asc;

	-- Problem 7: Identifying the Second Best Movie
	-- You are tasked with identifying the "second- best" movie in the Sakila database. 
    -- The ranking is determined by the rental rate, rental duration, and length. Management has specified the following rules for ranking the movies:
	-- First, rank the movies by rental_rate in descending order (lower is better).
	-- If there’s a tie, compare by rental_duration in descending order (longer is better).
	-- If there’s still a tie, compare by length in descending order (longer is better).

select * from film
order by rental_rate desc,
rental_duration desc, 
length desc

limit 1
offset 1;
