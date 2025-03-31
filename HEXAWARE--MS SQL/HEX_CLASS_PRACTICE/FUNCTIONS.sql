-------------------------FUNCTIONS-------------
--these are reusable code
--we can write a function and re use the same for several number  of times

/*
functions are classified into 2 main types
1)BUILT IN
these are again have 2 types
1)single row function ::it retruns the result for every row specified
2)group function/aggragete function :: it return an avg value or aggragte value fir the given values
2)USER DEFINED


1)BUILT IN :
these functions are ready to use 
we can use it directly
2 types
1)number functions
2)string functions
* 1)))number functions/arthimetic functions : these accpet numeric values amd return numeric values as output
*/
select abs(-123) as "Absolute value" --it converts -ve value to +ve value
select avg(empsal) from employees ---avarge of given values
select CEILING(27.57) as "celing value" --returns next nearesr integre value
select floor(25.75) as "floor value"  --rturn the previous nearesr integre value
select ACOS(0.25) as "degree to radians" --arc cosine
select count(empid) from employees --count the total noof woe/rows present in the table or guevn condition
select cos(30) as "cosvalue" --gives cosine value
select log(2) as "logarithm" --gives log value
select max(empsal) from employees --gives the maximun value from the given valuesand agregate
select min(empsal) from employees --gives the minimum value from the given valuesand agregate
select pi() as "pivalue";
select POWER(4,2) as "power value" --4^2
select RADIANS(180) as "radians value" --convert degrre value to radinas
select round(10.67787,3) as "round value" --it rounds to nearer desimal value
select sqrt(2) as "square root" --gives square root value
select sum(empsal) from employees;

/*
*string functions : it accepts string as paramerts and can return a string or integer value as output
* date and time functions
* advanced or misculennous functions
*/
select CHARINDEX('t','cusitomer') -- it returns character index for the return value
select char(65) as "character -ascii" -- it returns ascii value of the given numner
select CONCAT('python',' sql server')  --it concatinates to strings and form single string
select DATALENGTH('python')  --return total length of the given string
select DIFFERENCE('juicy','jucy')---comares to soundex value and return an integer :: return where the sound matches

declare @d datetime = '2018-03-24';  
select format(@d, 'd', 'en-US') as 'US English Result',   -- it return the format if soecified dt,date,time
       format(@d, 'd', 'nb-NO') as 'Norwegian Result';

select left('python progamming',3) as "left value" --extracts 3 char from left side
select len('python progamming') as "lenght ofstring" --gives lenghth inculding white spaces
select LOWER('pytHon prograMMmming') -- coverts all to lower it is a single row function that memas it effects for each row 
select upper('python progamming')
select ltrim('         python pramming')--trims all  leading blank spaces
select nchar(65) -- it accepts  assciinumbers and return the specified alphabet 
select PATINDEX('%programming%','pythonprogramming') as 'pattern index' -- gives index where pattern starts matching
select PATINDEX('%[programming]%','pythonprogramming') as 'pattern index' --check how many times it matches
select QUOTENAME('python') as "quote name" --justdisplays our quoute
select REPLACE('pythonprogramming','P','R') --change p to r whereve it is there
select REPLICATE('pythonprogramming',5) ---repetaes 5 times
select REVERSE('pythonprogramming') as "reverse_string"-- reverse
select RIGHT('pythonprogramming',4) -- extracs right most string
select RTRIM('pythonprogramming                ')
select SUBSTRING('pythonprogramming',2,7) as "substring" --starts from 2 and ends at 7
select trim('        python programming              ')--trim at both sides

--date and time functions
select CURRENT_TIMESTAMP as "date";
select dateadd(year,1,'2017/08/25') --adds date
select day('2017/08/25') as dayofmonth
select getdate() as "date-today" --gettodays date
select sysdatetime() as "system date" --get system date
select SYSTEM_USER ;--users name
select USER_NAME();

/*
2)USER DEFINED:
these are the functions that we create
we make to use it 
or we call to use it

*/