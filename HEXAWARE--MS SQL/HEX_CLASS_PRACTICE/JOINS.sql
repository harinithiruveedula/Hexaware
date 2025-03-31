----------------------------------------------------------------------JOINS----------------------------------------------------------------------------
--joins are used to retrive the data from two or more tables based on logical relationship
--between the tables
--there can be only one matching column from among the two tables
--based on it we can retrive multiple columns of the  multiple tables
--JOINING THE TABLES CLASSIFIED INTO 2 TYPES
--1) *SQL JOINS
--2)*SQL SERVER JOINS

------------------------------------------------------------------SQL SERVER JOINS-------------------------------------------------------------------
--a join condition that is propertory to sql serever is said to be as sql server join
--* SIMPLE
--**SELF
------------------------------------SIMPLE JOIN--------------------------------------------------
-- ** SIMPLE JOIN 1)equi 2) non-equi
--1) EQUI JOIN :: It represents the equalty of the rows from the table and based on eqaul to operator
select * from employees
select * from dept

select employees.emoname,employees.empsal,employees.empdeig,dept.deptname,dept.dept_id
from employees,dept
where employees.empid=dept.empid
----ALIAS---
select e.empid
from employees e
--here insetad of giving the full table name we will use alias to change the table name
--this name can be any name of our choice

--2)NON EQUI JOIN:: it is used to exract non-equlaity from the rows of table
--we make use of conditional or relational operators to extarct rows form the table

select a.empid,a.empsal,b.empid
from employees a,dept b
where a.empid>b.empid

select a.empdeig,a.emoname,b.dept_id
from employees a ,dept b
where a.empid<>b.empid
--<> every element is cpompared and return only non repetaed values
--that mean return didnvt vales
-----------------------------------------------------SELF JOIN------------------------------------

--** SELF JOIN:: a table joining to itself is said to be as self-join
--it is no use 
--but only used to check the relational functinality of a table

select a.emoname,a.empdeig,b.emoname
from
employees a,employees b
where a.empid=b.empid;

-----------------------------------------------------------------------SQL JOINS---------------------------------------------------
--these are common to all the database language
--that means same queries in oracle,plsql,mysql,ms sql

--the SQL JOINS ARE CLASSIFIES INTO
--1)OUTER JOIN::
--2)INNER JOIN

----------------------------------------------------------OUTER JOIN---------------
-- in outer join we have
--*LEFT OUTER JOIN
--*RIGHT OUTER JOIN
--* FULL JOIN
--*INNER JOIN
--*CARTESIAN JOIN
--its is the join condition
--it extarcts the additional rows from yhe table from the first query specified in outer join

-----------------------------------------------LEFT OUTER JOIN-------------------------------
--SYNTAX:
/*
left outer join
select *
from table_a as table_alias(a)
left outer join table_b as table_alias(b)
on a.common =b.common
*/
select e.emoname,d.deptname
from employees e
left outer join dept d
on e.empid=d.empid

-------------------------------RIGHT OUTER JOIN---------------
--it retrived all the record from the second table in the join condition
--rgardless whether there is a matching data or not
/*
syntax:
    select * 
	from table_a a
	right outer join table_b b
	on a.common=b.commmoncl
*/
select e.emoname,e.empid,d.deptname
from employees e
right outer join dept d
on e.empid=d.empid

-----------------------------FULL JOIN--------------------
--it joins all the rows from both the tables on matching condition

select e.emoname,e.empdeig,e.empid,d.dept_id
from employees e
full outer join dept d 
on e.empid=d.empid
---------------------------------------------------------------------------------------------INNER JOIN-------------------------------
--it is formd when twotables are combined
--it reytuen only common values on bot tables

select e.emoname,d.deptname
from employees e
inner join dept d
on e.empid=d.empid

------------------------------CATERSIAN PRODUCT----------------------------
-- a join without where condition is called cartesian product
--it multiplies all the row from the first quwer into the second query
--it is notused into project much

select e.empid,e.emoname,d.dept_id,d.deptname
 from employees e,dept d

 ---------------------------------JOINS WITH AGGREGATE FUNCTIONS----
 ---------------------------------JOINS WITH GROUP BY CLAUSE--------

 select employees.empdeig,
        employees.emoname,
		employees.empid,
        subtable.maxsal,
		subtable.minsal,
		subtable.avgsal,
		subtable.sumsal
from employees
inner join
		(
		select empdeig,
		max(empsal) maxsal,
		min(empsal) minsal,
		avg(empsal) avgsal,
		sum(empsal) sumsal
from employees 
group by empdeig
        )subtable
on employees.empdeig=subtable.empdeig

-----PARTITION
--this query finds the count of all dept 
--using over and partition clause
select distinct (deptname),
count(emoname) over (partition by employees.empid)emp
from employees
right outer join
on employees.empdeig=dept.empid

---------------------------GROUP BY----
--in joins we can use group by along with aggregate functions

