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