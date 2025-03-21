--Constrains--
/*
DEF::constarins are like condtion and rules applied on the table so that rows of the 
table will be secured so it will not violate integrity cinstarins
sql server has diffrent types constrains
1)NOT NULL
2)CHECK
3)UNIQUE
4)IDENTITY
5)PRIMARY KEY
6)FOREIGN KEY
7)DEFAULT
*/
/*
========================================NOT NULL===========================
==NULL VALUE==:: null values are missing information
when there is no data availbale it reprsent as null value
so to avoid this integrity problem we use NOT NULL constrains
*/
--creating a table using not null constrain
create table items(
itemno int not null,
item_name varchar(20) not null
);
--now if  to enter null values in item table 
--we get error
/*
===================================CHECK==================================
it imposes the condition upon the column of the table a
and it can accessed on criteria
*/
create table person(
id int not null, 
name varchar(20) not null,
age int  check(age>18)
);
insert into person values(100,'harini',10);
--here we get error because age is less than 18
=========primary key===========
/*
we can add modify delere constarins once created using alter 

*/
alter table person 
add constraint <constarint_type> <coulmn name>

create table rent(
house_id int,
rental_charges int,
locality varchar(20)
);

alter table rent
add constraint chk_rent check(rental_charges>5000);
select * from rent

--in same way we can add primary and unique constarisn and extra