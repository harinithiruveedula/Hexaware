use hex;
--to view entire table--
select * from employees;

--to retrive based on condtion--
--we use where---
select * from employees where empid>=11;

--------OPERATORS--------------
/*
operators operate on varaibles on columns
The list of Opertators are 
1)Arthimetic Operator:+,-,* / % ^
2)Conditional Operators: >, <, >=, <= ,!=
3)Logical Operators : AND(given both coditions should be satisfy),OR,NOT
*/

---AND Operator---
select * from employess where empid>100 and empsal>40000;

----OR operator----
--any one condition can be true
select * from employess where empid>100 or empsal>40000;

--NOT Operator---
---it retrives all the records which are not related to those condition
select * from employees where not empid>100;


--------------------SPECIAL OPERATORS-------------
/*
LIKE
BETWEEN--shows all the  values between given range 
IN
NOT IN 
*/
----------------------BETWEEN----------------------
select * from employees where empsal between 20000 and 50000;

-----------------------LIKE--------------------------
/* It has some wild crad charcters 
and these are special charcters 
There are two type of wild card charcter
1)%  --It reprsents mulitiple charcter
2) _ -- it reprsents single charcter
*/
select * from employees where  empname like 's%'; -- it starts with empname starts with s
select * from employees where  empname like '%h'; -- names ends with 'H'
select * from employees where  empname like '_u%'; -- it can start with any letter and can end with any no of alphaets  but second letter should be 'U'
-- here _ repersnets only single character--

----------------------------IN-------------------------
--it shows only the values which we give in IN condtion
select * from employees where desig in('Admin');
------------------------------NOT In-------------------
--it shows all the values not belongs those condition which give i
--it shows all records where it is not admin
select * from employees where desig not in('Admin');


