create  database hex;--create database 
use hex; 
--DDL comands 
--create,
--alter
--rename,
--truncate,
--drop

--creating a table 
--------CREATE-----------
create table employess(
empId int,
empname varchar(30),
empsalary int
);
--descrining the table query
exec sp_columns employees;

--adding a particular column
--alter command is used to create a new column or modify the existing column and drop a column

------------ALTER----------

alter table employess
add emp_designation varchar(30);

--modifying the existing column
--to improve column width no problem but to decreade we need to make column empty
alter table employess
alter column  empname varchar(40);

--dropping a column
alter table employess
drop column emp_designation;

-------- ----RENAME--------
--it reanames old table name to new name 
--in sql server there is no exculisve rename command 
--we have to exec built in command
exec sp_rename 'employess','emp';
--now our table name is emp

------TRUNCATE----
--delete all the rows from the table leaving the table stucture
truncate table emp;


-----DROP----
--delete entire table 
drop table emp;

---All the ddl commands are automatically saved
--hence we cannot rollback all the comands created by ddl

