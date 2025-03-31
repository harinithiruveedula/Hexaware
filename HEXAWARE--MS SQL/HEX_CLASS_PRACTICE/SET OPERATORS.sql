
----------------------------------------------SET--------------------------
--it relates two tables based on matching columns from both the tables
--IT has some operators 
--1)UNION
--2)UNION ALL
--3)INTERSECT
--4)MINUS
use hexaware_practice;

create table employees(
empid int,
emoname varchar(40),
empsal int,
empdeig varchar(50)
primary key(empid)
);
create table dept(
dept_id int,
deptname varchar(50),
loc varchar(40),
empid int
);

insert into dept values(100,'admin','mumbai',10);
insert into employees values(1,'harini',40000,'hr');


----UNION OPERATOR-----------
--it returns all the unique rows
--it displays the non duplicated rows from both tables
select empid from employees
union
select empid from dept;

-----------------------UNION ALL---------------
--it displays all row from both tbales irrespective of the duplication from 
--both tables
select empid
from employees
union all 
select  empid
from dept

----------------INTERSECT---------------
--it displays only the common values from the both tables
select empid 
from employees
intersect
select empid
from dept

------ MINUS----------
--it etracts the non related rows or non unique rows

select * from employees
minus
select * from dept
--it displays all the matching rows + non matching rows from the first query table
--A-B

--------------------------LIMITATIONS OF SET OPERATORS-------------
--there should be matching column from both tables to extract multiple columns 
--set operator is not a join condition to display the rows from the table
--it will not fit for rxtracting the large valume of data
