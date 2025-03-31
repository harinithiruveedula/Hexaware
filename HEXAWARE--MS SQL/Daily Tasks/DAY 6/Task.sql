
--1.Scenario: Extracting Data with Conditions
select * from Employees where salary>50000 and department='HR';

--2. Scenario: Finding Duplicate Records
select * from Orders group by CustomerId having count(CustomerId)>1 ;

--3. Scenario: Aggregating Data
select Productid,sum(qunatity) as total_quantity
from sales 
group by produtid;

--4. Scenario: Date Range Queries
select  TOP 30 * from transactions
order by TransactionDate desc;

--5. Scenario: Updating Records
update Products set price=price*1.10 where satockqunatity<100;

--6. Scenario: Deleting Specific Records
delete from Users where status='Inactive' and 

--9. Scenario: Handling NULL Values

select ProductName,coalesce(Discount,'No discount') as discount from products;
--10. Scenario: Ranking and Window Functions

--11 a query to fetch values in table test_a that are and not in test_b without using the NOT keyword.
create table test_a(id numeric);

create table test_b(id numeric);

insert into test_a(id) values
  (10),
  (20),
  (30),
  (40),
  (50);

insert into test_b(id) values
  (10),
  (30),
  (50);

  select * from test_a;
  select * from test_b;

select * from test_a
except
select * from test_b;

--SQL query to find the 10th highest employee salary from an Employee table. 

select distinct salary
from Employee
order by salary desc
off set 9 rows fetch next 1 row only;

--Write a query to insert/update Col2’s values to look exactly opposite to Col1’s values.Col1	Col2
create table col(col1 int,col2 int);

insert into col values(1,1),(1,0),(0,0);
select * from col;

update col
set col2 = case
when col1=1 then 0
when col1=0 then 1
end;
