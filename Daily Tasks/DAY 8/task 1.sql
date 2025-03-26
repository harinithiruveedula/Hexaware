--1
select *
from orders 
where salesman_id=
(select salesman_id from salesman where name='Paul Adam')

--2
select * 
from orders
where salesman_id in
(select salesman_id from salesman where city like 'London')

--3
select * 
from orders 
where salesman_id in
(select salesman_id from orders where customer_id=30007);

--4
select * 
from orders
where purch_amt>=
   (    
         select avg(purch_amt) 
          from orders
           where ord_date = '2012-10-10'
		   );

--5
select * 
from orders  where salesman_id in
(select salesman_id from salesman where city like 'New york')

--6
select commission,name
from salesman where salesman_id  in
(select salesman_id from salesman where city like 'paris')

--7
SELECT * 
FROM Customer 
WHERE customer_id = 2001 
AND salesman_id < (
    SELECT salesman_id 
    FROM Salesman 
    WHERE name = 'Mc Lyon'
);

--8
SELECT grade, COUNT(*) AS customer_count
FROM Customer
WHERE grade > (
    SELECT AVG(grade) 
    FROM Customer 
    WHERE city = 'New York'
)
AND city = 'New York'
GROUP BY grade;

--9
select o.ord_no,o.purch_amt,o.ord_date,o.salesman_id
from orders o where salesman_id=
(select salesman_id from salesman s where commission=
     (select max(commission) from salesman)
);

--10
select *
from customer
where salesman_id=
(select salesman_id from orders where ord_date='2012-08-17');

--11
SELECT salesman_id, name
FROM Salesman
WHERE salesman_id IN (
    SELECT salesman_id 
    FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) > 1
);

--12
select * 
from orders where purch_amt>
(select avg(purch_amt) from orders);

--13
select * 
from orders where purch_amt>=
(select avg(purch_amt) from orders);

--14

--15
select * 
from customer where exists
(select *  from customer where city like 'london')

--16
SELECT * 
FROM Customer 
WHERE salesman_id IN (
    SELECT salesman_id 
    FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) > 1
);

--17
select salesman_id,name,city,commission
from salesman where salesman_id in
(select salesman_id from customer
group by salesman_id
having count(customer_id)=1);

--18
select * 
from salesman 
where salesman_id in
(select salesman_id 
from customer
where customer_id in
( select customer_id from orders
group by customer_id
having count(ord_no)>1
));

--19
select salesman_id, name, city, commission
from salesman
where city in (
    select distinct city from customer
);

--20
select * 
from salesman
where city in (
    select distinct city from customer
);

--21
select * 
from salesman s where exists
(select 1 from customer c
where s.name<c.cust_name);

--22
select * from customer
where grade> all
(select grade from customer where city<'new york')

--23
select *
from orders
where purch_amt>any
(select purch_amt from orders where ord_date='2012-10-10')

--24
select * 
from orders where purch_amt<any
(select 
purch_amt from  orders 
where customer_id in
(select customer_id from customer
where city='london')
);

--25
select *
from orders where purch_amt<
(select max(purch_amt) from orders
where customer_id in
(select customer_id from customer where city='london'));

--26
select *
from customer where grade>
(select max(grade) from customer where city like 'new york');

--27
SELECT name AS salesperson_name, city, 
       (SELECT SUM(purch_amt) 
        FROM Orders 
        WHERE Orders.salesman_id = Salesman.salesman_id) AS total_order_amount
FROM Salesman
WHERE city IN (SELECT DISTINCT city FROM Customer);

--28
select * 
from customer where grade not in
(select  distinct grade from customer where city='london')

--29
select * 
from customer where grade not in
(select  distinct grade from customer where city='paris')

--30
select * 
from customer where grade not in
(select  distinct grade from customer where city='dallas')

--31
SELECT c.com_name, (SELECT AVG(p.pro_price)  
                          FROM item_mast p 
						   WHERE p.pro_com = c.com_id) AS average_price
FROM company_mast c;

--32
select com_name,
            (select avg(i.pro_price) 
			         from item_mast i where
					  c.com_id=i.pro_com
					  and 
					  i.pro_price>=350) as avg_price
from company_mast c

--33
SELECT c.com_name, 
       (SELECT MAX(i.pro_price) 
        FROM item_mast i 
        WHERE i.pro_com = c.com_id) AS maximum_price,
       (SELECT pro_name 
        FROM item_mast i 
        WHERE i.pro_price = (SELECT MAX(pro_price) 
                             FROM item_mast 
                             WHERE pro_com = c.com_id) 
        LIMIT 1) AS product_name
FROM company_mast c;

--34
select * 
from emp_details e
where e.last_name in ('Gabriel',' Dosio')

--35
select * 
from emp_details
where emp_dept in (89,63);

--36
SELECT emp_fname, emp_lname
FROM emp_details
WHERE emp_dept IN (
    SELECT dpt_code 
    FROM emp_department 
    WHERE dpt_allotment > 50000
);

--37
select dpt_code,dpt_name,dpt_allotment
from emp_department where dpt_allotment>
(select avg(dpt_allotment) from emp_department)

--38
select dpt_name
from emp_department where dept_code
(select emp_dept from emp_details
group by dpt_name
having count(emp_id)>2)

--39
select emp_fname,emp_lname
from emp_details where emp_dept=
(select dpt_code from emp_department where dpt_allotment=
             (select dept_allotment from emp_departemnt 
			 order by dept_allotment
			 limit 1 off set 1));



select * from company_mast
select * from item_mast
select * from orders;
select * from customer
select * from salesman