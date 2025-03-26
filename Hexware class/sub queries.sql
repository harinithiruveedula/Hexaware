-- when the size of query increases when the conditoon increases then it becomes difficult to
--handle at that time we use sub query
/*
in subquery we have two types
*parent query
* childquery

we can use select statement to return records 
--the outer query is called as parent query
--inner--child
--inner query return the results to iuter query
then outer qury displays the results based on inner query

advantages
-queries are not complex
-it is easily understandable
-can handle any number of queries
-can slove complex queries

--there are several operators used with subqueries
*all
*any
*some
note:in asunbquery the inner most select statement is excuted first 
and its result is passed asa criterai to outermost select statement
*/
-- we can nest upto 255 subquries
use hexaware_practice;
select * from customer where customer_id=
(select customer_id from customer where city=
(select city from customer where city like 'london'));
-- here it has more than onbe row
--when subquery return more than 1 row it genretes the excepetion
-- in that sceneorio we use 
-/*
any ,all,in ,exists are the keywords that can be used with where clauese with select statement
ALL:: when  it i used it return all 
*/
select * from customer where customer_id= all
(select customer_id from customer where city=all
(select city from customer where city like 'london'));

/*
GUIDELUNES:
-we cannot use text or ntext image datatyoes cannot used in select list of subquries
-the select list of a sub qury introduces with comparison operator can have only one expression
-sub queries that are ibtroduced by compariso operatt is not foloowed by keyowrd ANY OR i
cannot include group by and having claueses
--we cannot use ditinct keyword that included group by caluse
-we cannot soecify or compute into caluse in a subquery
--we can specify order by caluse only when top also specified

*/
select * from salesman  where salesman_id>=any
  (select salesman_id from salesman where city like 'London');
  
--ANY slecets row that are greater or lesser from the inner query
--we can also use some opertaor to slect row/s from the table

select * from salesman  where salesman_id>=some
  (select salesman_id from salesman where city like 'London');
  
--both any and some are used 

--USING EXISTS AND NOT EXISTS KEY WORD
--the key word exists is used with subqury to check the existenec of rows
--it will not return any data or it will retrn BOLEAN value
/*
synatx: 
select <colname> 
from <tablename>
where [not] exists
(
      <sub query statement>
)
*/

select salesman_id,name
from salesman
 where exists
    (
	select salesman_id from salesman where salesman_id=salesman.salesman_id and city='London'
	);

--firstly it check for salesman id from salesman
--that match with london
--then again it checks the salesman table

select  * 
from salesman
where not exists
(
  select * from salesman where city='London'
 );

 ---joining 

 select name +' '+city  as 'name and city'
 from salesman;

 ----IN OPERATOR

 select name +' '+city  as 'name and city'
from salesman
where salesman_id in
  ( 
     select salesman_id 
	 from customer
     where salesman_id in
       (
           select salesman_id from customer where city='London'
        )
   );

