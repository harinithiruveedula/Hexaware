--variables
--avaraible is an object that can hold the data value
--data can be passsed to sql staments using local variables
--In T-sql varavbiles can be crated for temporaray use while executing a batch of sql statemmntes

--varabiles are 2 types
--1)local varibales- declared locally...i.e user defined
--2)global variables-built in varaibles

--local variables are prefixed with @
--gloabal varables are prefixed with @@
use hex;

declare @empno int
set @empno=13 
select empid,empname,empsal from employees where empid=@empno;

