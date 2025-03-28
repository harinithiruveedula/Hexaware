use SISDB;

-- Viewing all the created tables
SELECT * FROM info.enrollments;
SELECT * FROM info.students;
SELECT * FROM info.payments;
SELECT * FROM info.teachers;
SELECT * FROM info.courses;

--1)Write an SQL query to calculate the average number of students enrolled in each course. 

SELECT c.course_name, 
       COUNT(e.student_id) AS student_count,
       (SELECT AVG(student_count) 
        FROM 
		(SELECT COUNT(student_id) AS student_count 
              FROM info.enrollments 
              GROUP BY course_id) AS course_counts) AS avg_students_per_course
FROM info.courses c
LEFT JOIN info.enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

---EXPLAINATION:
/*
first::retrieves the course name from the courses table.
--it counts the student count
--next entire  subquery calculates the average number of students per course.
              --> in that inner subquery ::Groups the enrollments table by course_id.
			  --->outer query::Uses AVG() to compute the average number of students per course.

*/

--2)Identify the student(s) who made the highest payment. 
select s.student_id,s.first_name,s.last_name,
                               (select   max(amount) from info.payments p
							   where s.student_id=p.student_id) as highest_amount
from info.students s
where s.student_id in
(select student_id from info.payments 
where amount=
(select max(amount) from info.payments))

------------explaination:
--first query near select statemnt get the highest amount 
---inner most query--max amount from payments
--outer query select that students id from payments table

--3)Retrieve a list of courses with the highest number of enrollments. 
select c.course_id,c.course_name,
                       (select count(*) from info.enrollments e where e.course_id=c.course_id) as enrollment_count
					   
from info.courses c
where c.course_id in
(SELECT course_id 
       FROM info.enrollments 
       GROUP BY course_id 
       HAVING COUNT(*) = (SELECT MAX(enrollment_count) 
                          FROM (SELECT COUNT(*) AS enrollment_count 
                                FROM info.enrollments 
                                GROUP BY course_id) AS subquery));
-----explaination:
---The first subquer near select setatemnt counts the number of students enrolled in each course.
--inner most :Find Maximum Enrollment Count:
--Retrieve Only Courses Matching the Maximum Count

--4)Calculate the total payments made to courses taught by each teacher. 

SELECT t.teacher_id, t.first_name, t.last_name, 
       (SELECT SUM(p.amount) FROM info.payments p
        WHERE p.student_id IN 
              (SELECT e.student_id FROM info.enrollments e 
			  WHERE e.course_id IN 
                     (SELECT c.course_id  FROM info.courses c 
                      WHERE c.teacher_id = t.teacher_id))) AS total_payments
FROM info.teachers t;

--the inner most subquery Identify Courses Assigned to Each Teacher
--the inner query find Students Enrolled in These Courses
--the outer query Sum Payments Made by These Students
--and at last Retrieve Teacher Details Along with the Total Payments

--5)Identify students who are enrolled in all available courses. 
SELECT s.student_id, s.first_name, s.last_name
FROM info.students s
WHERE (SELECT COUNT(DISTINCT e.course_id) 
       FROM info.enrollments e 
       WHERE e.student_id = s.student_id) = 
      (SELECT COUNT(*) FROM info.courses);
--explaination::
--inner  subquery Count the Number of Courses a Student is Enrolled In
--outer subquery Count the Total Number of Available Courses

--6)Retrieve the names of teachers who have not been assigned to any courses. 
SELECT t.teacher_id, t.first_name, t.last_name
FROM info.teachers t
WHERE t.teacher_id NOT IN 
      (SELECT DISTINCT c.teacher_id FROM info.courses c WHERE c.teacher_id IS NOT NULL);

--Explaination:
--inner sybquery  Find Teachers Assigned to Courses
--Exclude These Teachers from the Main Query

--7)Calculate the average age of all students. 
SELECT AVG(student_age) AS average_age 
FROM (
    SELECT DATEDIFF(YEAR, s.date_of_birth, GETDATE()) AS student_age
    FROM info.students s
) AS age_subquery;

--Calculate Age for Each Student (Subquery)
--outer query Calculate the Average Age

--8)Identify courses with no enrollments. 
SELECT course_id, course_name 
FROM info.courses 
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM info.enrollments
);

--explaination::
--Subquery (Find Enrolled Courses)
--Main Query (Find Courses Not in the Enrolled List):

--9)Calculate the total payments made by each student for each course they are enrolled in.
SELECT s.student_id, 
       s.first_name, 
       s.last_name, 
       c.course_name, 
       (SELECT SUM(p.amount) 
        FROM info.payments p 
        WHERE p.student_id = s.student_id) AS total_paid
FROM info.students s
JOIN info.enrollments e ON s.student_id = e.student_id
JOIN info.courses c ON e.course_id = c.course_id;
--expliantion::
--Joins students to enrollments and courses
--subquery::Sums the total payment made by the student (p.student_id = s.student_id).

--10)Identify students who have made more than one payment. 
SELECT student_id, first_name, last_name 
FROM info.students 
WHERE student_id IN (
    SELECT student_id 
    FROM info.payments 
    GROUP BY student_id 
    HAVING COUNT(payment_id) > 1
);
--explaination::
--inner sub query::Groups the payments table by student_id.
--Filters out students who have only one or zero payments (HAVING COUNT(payment_id) > 1)
--outer query Retrieves student_id, first_name, and last_name from the students table.

--11)Write an SQL query to calculate the total payments made by each student. Join the "Students" 
--table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
SELECT s.student_id, 
       s.first_name, 
       s.last_name, 
       (SELECT SUM(p.amount) 
        FROM info.payments p 
        WHERE p.student_id = s.student_id 
        GROUP BY p.student_id) AS total_payments
FROM info.students s
ORDER BY total_payments DESC;

--explaination
--joining studntes and payments
--query The subquery calculates the total payments made by each student.
--GROUP BY p.student_id: Ensures the sum is calculated per student.
--Sorting the Results in desc

--12)Retrieve a list of course names along with the count of students enrolled in each course. 
--use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments

SELECT c.course_name, 
       COUNT(e.student_id) AS student_count
FROM info.courses c
LEFT JOIN info.enrollments e 
ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY student_count DESC;
--explaination
--joining the course table and enrollments table
--Counting Enrolled Students
--Grouping by Course Name
--Sorting the Results

--13)Calculate the average payment amount made by students.
--Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.

SELECT s.student_id, 
       s.first_name, 
       s.last_name, 
       AVG(p.amount) AS avg_payment
FROM info.students s
JOIN info.payments p 
ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY avg_payment DESC;
--explaination::
--Selecting Student Details
--Calculating Average Payment
--Joining Students with Payments
--Grouping by Student
--ordering them 



-- Viewing all the created tables
SELECT * FROM info.enrollments;
SELECT * FROM info.students;
SELECT * FROM info.payments;
SELECT * FROM info.teachers;
SELECT * FROM info.courses;
go
SELECT * FROM info.enrollments;