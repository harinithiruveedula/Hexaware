use hexaware_practice;


--------------------TASK 1-------------------------
--transferring  tables from one database to another database
  
use hexaware_practice;--current using databse

select  name from sys.tables    --viweing all the tables
USE hex;  --databae name where we have to change our tables

SELECT * INTO hex.dbo.customer FROM hexaware_practice.dbo.customer;
select  name from sys.tables   --to view allexisting tables

 ----------------------------------------------------------TASK 2---------------------------------
 --transfer the tables along with schema

--creating a schema 
create schema harini_thiruveedula;
CREATE SCHEMA harini;

---created a table using schema
create table harini_thiruveedula.emp(
id int,
name varchar(20));
---now changing emp table to harini schema from harini_thiruveedula schema

alter schema harini
transfer harini_thiruveedula.emp;

select name from sys.tables

-----------------------------------------------------TASK 3---------------------------
--like giving only accesto trusted authors

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::harini TO AuthorizedUser;


