/*
================XML======================
extensible markup language 
these are calassified into 2types
1)HTML -- hyper text markup language -> tag defination lang --has prdefined tag
2)XML ---extensible markup language -> tag description lang--user defined tags
--tag defination lang is a web page prsentable language 
where as xml nothng to prsent but we can store the data into int
XML IN databases have many advantages

usage of xml

* easy data search and managemnt
*better performance
* easy data processing
--> to sore  XML data in sql server
in addition to regulary commonly used datatype.sql provides XML datatype
which is used to XML document and fragments in SQL server

*/
create table personal_exp(
phonebillid int primary key,
mobileno bigint unique,
calldetails  xml ----here we are using XML datatype
);
insert into personal_exp values(100,8976234567,
'<info>
<call> Local Call</call>
<time>40 minutes</time>
<charges>200</charges>
</info>');
select * from personal_exp;
--this is how we store our xml data 