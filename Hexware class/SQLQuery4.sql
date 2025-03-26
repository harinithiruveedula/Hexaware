create table emp_tab(
empid int not null,
first_name varchar(30),
last_name varchar(40),
salary int);

insert into emp_tab values
(100,'suresh','kumar',50000),
(101,'Ramesh','Kumar',60000),
(102,'Gopi','Nathan',75000),
(103,'sachin','tendulakr',80000),
(104,'virat','kohli',700000),
(105,'rohit','sharma',98000),
(106,'ravindra','jadeja',679000),
(107,'mayank','shaha',780000),
(109,'Bruce','Agarwal',80000),
(110,'rakesh','sharma',90000);

select* from emp_tab;
--1)
select e.first_name,e.last_name
from emp_tab e
where salary>all
(select salary from emp_tab where empid=103);

--using joins
select  e1.first_name,e1.last_name
from emp_tab e1
join emp_tab e2
on e1.salary>e2.salary
where e2.empid=103;

--using exists
select e.first_name,e.last_name
from emp_tab e
where exists
(
select 1  --
from emp_tab e2 
where e2.empid=103 and e.salary>e2.salary 
);
alter table emp_tab
add dept_id int;
--2)
select * from emp_tab

--3)
select  e.first_name,e.last_name,e.empid
from emp_tab e where salary>
(select avg(salary) from emp_tab)

--using joins
select  e.first_name,e.last_name,e.empid
from emp_tab e
join 
(select avg(salary) as avg_salary 
from emp_tab)
avg_emp --creatig one more sub query with avg_emp table
on e.salary>avg_emp.avg_salary
alter table  emp_tab
add manger_id int;

--4
select e.first_name,e.last_name,e.empid,e.salary
from emp_tab e
where manger_id=all
(select empid from emp_tab where e.first_name='Rohit')

--using exists
select e.first_name,e.last_name,e.empid,e.salary
from emp_tab e
where  exists
(select 1 from emp_tab e2
where e.manger_id=e2.manger_id and e2.first_name='rohit')

--IN

select e.first_name,e.last_name,e.empid,e.salary
from emp_tab e
where manger_id in
(select empid from emp_tab where e.first_name='Rohit')

--5
select  *
from emp_tab e1
join emp_tab e2
on e1.manger_id=e2.empid
where e1.salary=7000 and e2.manger_id=104;

select * from emp_tab
