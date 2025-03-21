create table employees(
empid int,
empname varchar(20),
empsal int,
desig varchar(20));

------DML-----
--Insert
--update
--delete
--select
--DML is divided to DQL(sleect)
--these commands are used for Inserting,update,delete
--data manipulation language

---------------INSERT------------
--insert records into table
insert into employees(empid,empname,empsal,desig) 
values
(10,'harini',75000,'manager');


---we can insert multiple values at a time
insert into employees values
(11,'suresh',50000,'Admin'),
(12,'ramesh',80000,'Backend Developer'),
(13,'Ram',50000,'HR');

-----------------UPDATE-----------------------
--this command used to update the rows from the table

update employees set empsal=90000 where empid=13;

-------------------DELETE--------------------
--this command is used to delete the rows from the table

delete from employees where empid=13;

--------------SELECT----------------------
--it is used to select the rows from the table based on the criteria 
--retrving entire table
select * from employees;

--choosing only some columns
select empid,empname from employees;

---selecting in asc or desc order
--asceding order 
select * from employees order by empid asc;

--retrving all the employess in descing order of salary
select * from employees order by empid desc;

--retrving all the employess where salary is greater than 40000
select * from employees where empsal>40000;

--