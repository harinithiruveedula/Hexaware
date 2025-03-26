/*
in many queries conataining sub query ,the sub query needs t be evlated only once to provide
the values need by parent qury
this is most of the queries the subquery makes no refrenve to parent qury
*/
--the correalted sub query depends on outer query
--it is alos called as nested query
use hexaware_practice;
select salesman_id
from  salesman
where 'london'
in
(
select salesman_id from salesman where salesman_id=salesman_id
);

select * from salesman
select * from customer
------------------merge statement
--itallows insert update delte records but based on the conditions
merge into customer as target
using salesman as source
on target.salesman_id=source.salesman_id
when matched then update set target.city=source.city
when not matched then insert(salesaman_id,name,city,commission) values(source.salesman_id,source.name)
when not matched by source then delete

--merge is a subqury is intocuced to perform dml opetations at a time
--