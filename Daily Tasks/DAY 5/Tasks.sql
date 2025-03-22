use Techshop;
--------------task1------------
create table Library(
bookid int not null unique,
book_name varchar(20) not null,
published_year int check(published_year>2000)
);
exec sp_helpconstraint 'Library';

---------------TASK 2------------------
create table student(
id varchar(20),
name varchar(20),
dept  varchar(20),
marks int
);
insert into student values(10,'harini','cse',90),(10,'harini','cse',90);
select * from student;
 
update top(1) student 
set id=12 where name='harini';
--to view the table
select * from  student;

-----------------TASK 3--------------

CREATE TABLE employee (
    id varchar(20),
    name VARCHAR(20),
    salary money,
);
--adding constrains
alter table employee
add constraint salary  check (salary>60000);
--not null
alter table employee
alter column name varchar(20) not null;