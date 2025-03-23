------------TASK 3--------------
--using  the database that we have created
use SISDB;
--viewing all the created tables

select * from enrollments;
select * from students;
select * from payments;
select * from teachers;
select * from courses;



--1)Write an SQL query to calculate the total payments made by a specific student.
select s.first_name,
       s.last_name,
	   sum(p.amount) as amount_paid,
	   count(p.payment_id) as no_of_payments 
from payments P
inner join students s
on p.student_id=s.student_id
group by s.student_id,s.first_name,s.last_name
order by amount_paid desc;
---LOGIC USED:
-->SUM(p.amount) AS total_amount_paid::Calculates the total payment amount
-->COUNT(p.payment_id) AS no_of_payments :: Counts the number of payments
-->ORDER BY no_of_payments DESC :: Sorts students by most payments first 

--2)Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. 
select c.course_id,
       c.course_name,
	   count(distinct e.student_id) as students_count
from courses c
inner join enrollments e
on c.course_id=e.course_id
group by c.course_id,c.course_name
order by students_count desc;
---LOGIC USED:
--using join to combine tables
--using aggregate function "COUNT" to count 
--grouping them by course name and ordering them in descending order.

--3)Write an SQL query to find the names of students who have not enrolled in any course. 
select s.first_name,
       s.last_name,
	   s.student_id
from students s
left join enrollments e
on s.student_id=e.student_id
where e.course_id is null;
---LOGIC USED:
-->using left join to get all students names that not enrolled in courses
-->using "WHERE" clause to check condition
-->IS NULL:: shows that which student does not enrolled

--4)Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. 
select s.student_id,
       s.first_name,
       s.last_name,
	   c.course_name 
from students s
inner join enrollments e
on  s.student_id=e.student_id
inner join courses c
on e.course_id=c.course_id;
---LOGIC USED:
-->using multiple joins to combine multiple tables

--5)Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

select t.teacher_id,
       t.first_name,
	   t.last_name,
	   c.course_name
from teachers t
inner join courses c
on t.teacher_id=c.teacher_id;
---LOGIC USED:
-->using inner join to combine both tables

--6)Retrieve a list of students and their enrollment dates for a specific course. 
select s.first_name,
       s.last_name,
	   c.course_name,
	   e.enrollment_date
from students s
inner join enrollments e
on s.student_id=e.student_id
inner join courses c
on e.course_id=c.course_id
where lower(c.course_name)='Machine learning';

---LOGIC USED
--> using where clause to retrive data for specifc course

--7)Find the names of students who have not made any payments.

select  s.student_id,
        s.first_name,
       s.last_name
from students s
left join payments p
on s.student_id=p.student_id
where p.payment_id is null
---LOGIC USED:
--> using left join to retrive all the students
-->by where claues and is null we get who didnot paid amount

--8)Write a query to identify courses that have no enrollments. 
select c.course_name,
       c.course_id
from courses c
left join enrollments e
on c.course_id=e.course_id
where e.enrollment_id is null
---LOGIC USED:
--> using left join to retrive all the course names
-->where is used to filter records

--9)Identify students who are enrolled in more than one course
--Method1:
select s.student_id,
       s.first_name,
       s.last_name,
	   count(e.course_id) as no_of_courses_enrolled
from students s
inner join enrollments e
on s.student_id =e.student_id
group by s.student_id,s.first_name,s.last_name
having count(e.course_id)>1
order by no_of_courses_enrolled desc;

--Method 2:
select 
    e1.student_id, 
    s.first_name, 
    s.last_name, 
    count(distinct e1.course_id) as no_of_courses_enrolled
from enrollments e1
join enrollments e2
on e1.student_id = e2.student_id 
and 
e1.course_id <> e2.course_id 
join students s 
on e1.student_id = s.student_id
group by e1.student_id, s.first_name, s.last_name
having count(distinct e1.course_id) > 1
order by no_of_courses_enrolled desc;
---LOGIC USED:
-->making self join
-->  <> retrvies only distinct courses
-->grouping them
--> bu using "Having" along with aggregate functions
--> ordering them in descending order


--10)Find teachers who are not assigned to any courses. 
select t.teacher_id, 
       t.first_name,
	   t.last_name
from teachers t
left join courses c
on t.teacher_id=c.teacher_id
where c.course_id is null

---LOGIC USED:
-->using left join to get all the teachers
--where is used filter the teachers
--IS NULL operator shows that teachers not assigned to any course
