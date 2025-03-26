-----new database creation--------------

create database [hexaware] on primary 
(name=N'heaware',filename=N'D:\hexaware.mdf')
log on
(name=N'heaware_log',filename=N'D:\hexaware.ldf')
collate sql_Latin1_general_cp1_ci_AS;

-----altering our database name
alter database hexaware
modify name=Employees

------now we create a schema
use Employees --use databse
create schema manager; --create
--from this schema we will create tables
create table employees.manager.emp_details(id int);
insert into Employees.manager.emp_details values (1);
---creating synonym
create synonym manager.sy_emp
for 
manager.emp_details;
--
select * from manager.sy_emp


