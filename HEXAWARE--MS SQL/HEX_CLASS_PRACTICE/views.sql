--------------------creating views
--used to duplicate table but based on condition

use hexaware_practice
select * from company_details

--creating view
create view v1 as
select * from company_details where com_id>12;
--to get view
select * from v1;

--creating viwes with the help of joins

select * from company_details;
select * from item_mast;

create view v2 as
select * from company_details c 
join item_mast i
on c.com_id=i.pro_com
where c.com_name='samsung';

--to view that 
select * from v2;