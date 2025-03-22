

--1.Write a SQL statement that displays all the information about all salespeople.
select * from salesman;

--2.2.Write a SQL statement to display specific columns such as names and commissions for all salespeople.  
select name,commison from salesman;

--3.Write a query to display the columns in a specific order, such as order date, salesman ID, order number, and purchase amount for all orders. 
Select ord_date, salesman_ID, ord_no, purch_amt From orders;

--4.From the following table, write a SQL query to identify the unique salespeople ID. Return salesman_id. 
select distinct salesman_id from orders

--5From the following table, write a SQL query to locate salespeople who live in the city of 'Paris'. Return salesperson's name, city. 
select name,city from salesman where city='paris'


--6.From the following table, write a SQL query to find customers whose grade is 200. Return customer_id, cust_name, city, grade, salesman_id.  
select customer_id, cust_name, city, grade, salesman_id from customer where grade=200;


--7From the following table, write a SQL query to find orders that are delivered by a salesperson with ID. 5001. Return ord_no, ord_date, purch_amt.  
SELECT ord_no, ord_date, purch_amt  FROM orders WHERE salesman_id = 5001;

--8.From the following table, write a SQL query to find the Nobel Prize winner(s) for the year 1970. Return year, subject and winner. 
select year, subject,winner from the nobel_win where year=1970;



--9)9.From the following table, write a SQL query that combines the winners in Physics, 1970 and in Economics, 1971. Return year, subject, winner, country, and category. 
SELECT year, subject, winner, country, category  FROM nobel_win WHERE (subject = 'Physics' AND year = 1970) OR (subject = 'Economics' AND year = 1971);



--10)10.From the following table, write a SQL query to combine the winners in 'Physiology' before 1971 and winners in 'Peace' on or after 1974. Return year, subject, winner, country, and category. 
select year, subject, winner, country, category from nobel_win where (subject='physilogy'  and year<1971)or (subject='peace' and year>=1974);

