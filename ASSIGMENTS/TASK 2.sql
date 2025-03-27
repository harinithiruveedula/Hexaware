---using our created database
use SISDB;
--viewing all the created tables
SELECT * FROM info.students;
SELECT * FROM info.teachers;
SELECT * FROM info.courses;
SELECT * FROM info.enrollments;
SELECT * FROM info.payments;
--1)Write an SQL query to insert a new student into the "Students" table
INSERT INTO info.students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

--2)Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.
INSERT INTO info.enrollments (student_id, course_id, enrollment_date)
VALUES (3, 5, '2024-03-23');
--3)Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
UPDATE info.teachers 
SET email = 'kavitha05.das@gmail.com' 
WHERE teacher_id = 10;
-->>LOGIC USED:
             --by using "UPDATE" staement  we have updated a particular email

--4)Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select  an enrollment record based on the student and course
DELETE FROM info.enrollments 
WHERE student_id = 1 AND course_id = 1;

 -->>LOGIC USED:
				--by using DELETE we have deleted entire record


--5)Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.

UPDATE info.courses 
SET teacher_id = 3 
WHERE course_name = 'machine learning';
-->>LOGIC USED:
            --by using "UPDATE"
			--using "WHERE" to check the given condition

--6)Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.
DELETE FROM info.students WHERE student_id = 1;
-->LOGIC USED:
              --when creating a table we have set" ON DELETE CASCADE"
			  -- so it automatically remove the data from enrollments table also

--7)Update the payment amount for a specific payment record in the "Payments" table. Choose any  payment record and modify the payment amount.
UPDATE info.payments 
SET amount = 202500.00 
WHERE payment_id = 6;
-->LOGIC USED:
            --using "UPDATE" to update the particular record with
			--the help of "WHERE" clause