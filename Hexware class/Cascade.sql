/*
ON DELETE :
when it is asscoiated with foreigm key 
when we a delete a row from base table then it subsequntly delete 
a row in child table also
NOTE: when we try to drop a base table it will not allow us to drop 
beacuse there is a subsequent child table availble 
hence first we need to delete chilfd table and again base table

in other lang like mysql,oracle we can delete with force option
but in ms sql server w ehave to 
drop child table first
then drop the base table
================================ON DELETE CASACDE===========================
*/
create table cust_details(
cust_id int not null,
cust_name varchar(20),
bankname varchar(20),
amtdep money
primary key(cust_id)
);
insert into cust_details values
(10,'harini','union',90000),
(11,'hari','union',90000);

create table bank_details(
banid int,
bankname varchar(20),
cust_id int,
foreign key(cust_id) references cust_details(cust_id)
on delete cascade
);
insert into bank_details values
(123,'union',10),
(129,'union',11);
select * from cust_details;
select * from bank_details;
---now we can delete the values from base table i.e parent table so that 
--it gets automatically delted in child table
delete from cust_details where cust_id=10;