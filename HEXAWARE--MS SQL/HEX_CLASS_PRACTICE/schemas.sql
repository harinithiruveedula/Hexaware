use hexaware_practice;
--creating a schema
create schema harini;
go

create table harini.emp(emid int,name varchar(30));
-- to viewall system created scHEMS
select * from sys.schemas

--transfer schema

create table dbo.demotable(id int,name varchar(20));
insert into dbo.demotable values(1,'harini'),
(2,'sai'),
(3,'mini');


---altering  demo table from  schema dbo-schema harini
alter schema harini
transfer object ::dbo.demotable;

----1) creating a stored procudure:
create procedure sp_get_id(@id int) as
begin
  select * from dbo.demotable where id=@id;
end ;

--before we have created procudire for dbo.table but now it is not tere so 
--alter procudure now

alter procedure sp_get_id(@id int) as
begin
  select * from harini.demotable where id=@id;
end ;
--run this procudure
exec sp_get_id 1;

--alter
--used to change table from one schema to another schema
--it is transactional that is it can be rool back ifnthe error occurs during data integrity
