--Temporary table

create table newemployee(
empid int,
name char(10)
);
insert into newemployee values(1,'harini');

with employeetemp(empid,name)
as
(
select * from newemployee
)
insert into employee

select * from employeetemp
---this are used procdures and this is called as common table expression
-- when we use a functions or functions or curosrs in PL SQL prgming 
--when we create a stored procdures it is mandtory to create  a temp table 

