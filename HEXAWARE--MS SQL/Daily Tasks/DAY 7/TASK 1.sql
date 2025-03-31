use hexaware_practice;
-- Create the salesman table 
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);

-- Insert data into the salesman table
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

-- Create the customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT NULL,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into the customer table
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);

-- Create the orders table 
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into the orders table
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006);
--viwewing the tables
select * from salesman;
select * from customer;
select * from orders;

--1)From the following tables write a SQL query to find the salesperson and customer who reside in the same city.
--Return Salesman, cust_name and city.

select s.name,c.cust_name,s.city
from salesman s
inner join customer c
on s.salesman_id=c.salesman_id
where s.city=c.city 

--2)From the following tables write a SQL query to find those orders where the order amount exists between 500 and 2000.Return ord_no, purch_amt, cust_name, city.

select c.cust_name,c.city,o.ord_no,o.purch_amt
from customer c
inner join orders o
on c.customer_id=o.customer_id
where o.purch_amt between 500 and 2000;


--3)From the following tables write a SQL query to find the salesperson(s) and the customer(s) he represents.
--Return Customer Name, city, Salesman, commission.
select c.cust_name,c.city,s.name as salesman,s.commission
from salesman s
inner join customer c
on s.salesman_id=c.salesman_id

--4)From the following tables write a SQL query to find salespeople who received commissions of more than 12 percent from the company. 
--Return Customer Name, customer city, Salesman, commission.  

select c.cust_name,c.city,s.name as salesman ,s.commission as commison_recivied
from salesman s
left join customer c
on s.salesman_id=c.salesman_id
where s.commission>0.12

--5)From the following tables write a SQL query to locate those salespeople who do not live in the same city where their customers live
--and have received a commission of more than 12% from the company.
--Return Customer Name, customer city, Salesman, salesman city, commission.

select c.cust_name,c.city,s.name,s.city,s.commission
from salesman s
inner join customer c
on s.salesman_id=c.salesman_id
where s.city !=c.city 
and
s.commission>0.12

--6)From the following tables write a SQL query to find the details of an order. 
--Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.  

select o.ord_no,o.ord_date,o.purch_amt,c.cust_name,c.grade,s.name as salesman,s.commission
from orders o
inner join customer c
on o.customer_id=c.customer_id
inner join salesman s
on c.salesman_id=s.salesman_id

--7)Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once
--and only the relational rows are returned. 

select 
    o.ord_no, 
    o.ord_date, 
    o.purch_amt, 
    c.cust_name, 
    c.city as customer_city, 
    c.grade, 
    s.name as salesman, 
    s.city as salesman_city, 
    s.commission 
from orders o
inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on c.salesman_id = s.salesman_id;

--8)From the following tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city. 
--The results should be sorted by ascending customer_id. 

select c.cust_name,c.city as cust_city,c.grade,s.name as s_name,s.city as s_city
from customer c
inner join salesman s
on c.salesman_id=s.salesman_id
order by c.customer_id asc;

--9)From the following tables write a SQL query to find those customers with a grade less than 300.
--Return cust_name, customer city, grade, Salesman, salesmancity. 
--The result should be ordered by ascending customer_id. 
 select c.cust_name,c.city as c_city,c.grade,s.name as s_name,s.city as s_city
 from  customer c
 inner join salesman s
 on c.salesman_id=s.salesman_id
 where c.grade<300
 order by c.customer_id asc;

 --10)Write a SQL statement to make a report with customer name, city, order number, order date, 
 --and order amount in ascending order 
 --according to the order date to determine whether 
 --any of the existing customers have placed an order or not.

 select 
    c.cust_name, 
    c.city, 
    o.ord_no, 
    o.ord_date, 
    o.purch_amt 
from customer c
left join orders o
on c.customer_id = o.customer_id
order by o.ord_date asc;

--11)SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission
--to determine if any of the existing customers have not placed orders or
--if they have placed orders through their salesman or by themselves.

select  c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt,s.name,s.commission
from customer c
left join orders o
on c.customer_id=o.customer_id
inner join salesman s
on c.salesman_id=s.salesman_id
order by c.cust_name;

--12)Write a SQL statement to generate a list in ascending order of salespersons 
--who work either for one or more customers or have not yet joined any of the customers.

select s.name,count(c.customer_id) as no_of_customers
from salesman s
left join customer c
on s.salesman_id=c.salesman_id
group by s.name
order by no_of_customers desc;

--13)From the following tables write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount
--Condition for selecting list of salesmen : 1. Salesmen who works for one or more customer or, 2. Salesmen who not yet join under any customer, 
--Condition for selecting list of customer : 3. placed one or more orders, or 4. no order placed to their salesman.

select s.name,c.cust_name,c.city,c.grade,o.ord_no,o.ord_date,o.purch_amt
from salesman s
left join  customer c
on s.salesman_id=c.salesman_id
left join orders o
on c.customer_id=o.customer_id;

--14)Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer.
--The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade,
--or he may not have placed any order to the associated supplier.

select s.name AS salesman, 
    c.cust_name, 
    c.city, 
    c.grade, 
    o.ord_no, 
    o.ord_date, 
    o.purch_amt  
from salesman s
left join customer c
on s.salesman_id=c.salesman_id
left join orders o
on c.customer_id=o.customer_id
where (o.purch_amt>=20000 and c.grade is not null)
or o.ord_no is null
order by s.name,c.cust_name

--12)For those customers from the existing list who put one or more orders, 
--or which orders have been placed by the customer who is not on the list, 
--create a report containing the customer name, city, order number, order date, and purchase amount

select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt
from customer c
full join  orders o
on c.customer_id=o.customer_id
where o.ord_no is not null

--16)Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount 
--for only those customers on the list who must have a grade and placed one or more orders 
--or which order(s) have been placed by the customer who neither is on the list nor has a grade.

select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt
from customer c
inner join orders o
on c.customer_id=o.customer_id
where (c.grade is not null  and o.ord_no is not null)
or (c.customer_id is null or c.grade is null)

--17)Write a SQL query to combine each row of the salesman table with each row of the customer table.
select * 
from salesman 
cross join customer

--18)Write a SQL statement to create a Cartesian product between salesperson and customer,
--i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city.

select * 
from salesman s
cross join customer c
where s.city=c.city;

--19) Write a SQL statement to create a Cartesian product between salesperson and customer, 
--i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city 
--and customers who require a grade.

select * 
from salesman s
cross join customer c
where (s.city=c.city and c.grade is not null);

--20)Write a SQL statement to make a Cartesian product between salesman and customer 
--i.e. each salesman will appear for all customers and vice versa for those salesmen who must belong to a city 
--which is not the same as his customer and the customers should have their own grade.
select *  
from salesman s  
cross join customer c  
where (s.city <> c.city and c.grade is not null);

create table company_mast (
    com_id int primary key,
    com_name varchar(50) not null
);

create table item_mast (
    pro_id int primary key,
    pro_name varchar(100) not null,
    pro_price decimal(10,2) not null,
    pro_com int,
    foreign key (pro_com) references company_mast(com_id)
);
insert into company_mast (com_id, com_name) values (11, 'samsung');
insert into company_mast (com_id, com_name) values (12, 'iball');
insert into company_mast (com_id, com_name) values (13, 'epsion');
insert into company_mast (com_id, com_name) values (14, 'zebronics');
insert into company_mast (com_id, com_name) values (15, 'asus');
insert into company_mast (com_id, com_name) values (16, 'frontech');

insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (101, 'mother board', 3200.00, 15);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (102, 'key board', 450.00, 16);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (103, 'zip drive', 250.00, 14);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (104, 'speaker', 550.00, 16);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (105, 'monitor', 5000.00, 11);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (106, 'dvd drive', 900.00, 12);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (107, 'cd drive', 800.00, 12);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (108, 'printer', 2600.00, 13);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (109, 'refill cartridge', 350.00, 13);
insert into item_mast (pro_id, pro_name, pro_price, pro_com) values (110, 'mouse', 250.00, 12);

select* from company_mast;
select * from item_mast

--21)
select * 
from company_mast c
inner join item_mast i
on c.com_id=i.pro_com;

--22)
select i.pro_name,i.pro_price,c.com_name
from company_mast c
right join item_mast i
on c.com_id=i.pro_com

--23)
select c.com_name,avg(i.pro_price) as average_price
from company_mast c
inner join item_mast i
on c.com_id=i.pro_com
group by c.com_name
order by average_price desc;

--24)
select c.com_name,avg(i.pro_price) as average_value
from company_mast c
inner join item_mast i
on c.com_id=i.pro_com
group by c.com_name
having avg(i.pro_price)>=350
order by average_value desc;

--25)
select  c.com_name,i.pro_price,i.pro_name
from company_mast c
inner join item_mast i
on c.com_id=i.pro_com
where i.pro_price = 
(  
    select max(i2.pro_price)  
    from item_mast i2  
    where i2.pro_com = i.pro_com  
);


--26)
select e.emp_idno, e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment  
from emp_details e  
inner join emp_department d  
on e.emp_dept = d.dpt_code;  

--27)
select e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment  
from emp_details e  
inner join emp_department d  
on e.emp_dept = d.dpt_code;

--28)
select e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment  
from emp_details e  
inner join emp_department d  
on e.emp_dept = d.dpt_code  
where d.dpt_allotment > 50000;

--29)
select d.dpt_name  
from emp_department d  
inner join emp_details e  
on d.dpt_code = e.emp_dept  
group by d.dpt_name  
having count(e.emp_idno) > 2;
