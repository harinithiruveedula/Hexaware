-- Using the created database
USE SISDB;

-- Viewing all the created tables
SELECT * FROM info.enrollments;
SELECT * FROM info.students;
SELECT * FROM info.payments;
SELECT * FROM info.teachers;
SELECT * FROM info.courses;

-- 1) Calculate the total payments made by a specific student
SELECT s.first_name,
       s.last_name,
       SUM(p.amount) AS amount_paid,
       COUNT(p.payment_id) AS no_of_payments 
FROM info.payments p
INNER JOIN info.students s
ON p.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY amount_paid DESC;
---LOGIC USED:
--> Using SUM() to calculate the total amount paid by each student.
--> Using COUNT() to determine the number of payments made.
--> Using ORDER BY to sort students based on the highest total payment.

-- 2) Retrieve a list of courses along with the count of students enrolled in each course
SELECT c.course_id,
       c.course_name,
       COUNT(DISTINCT e.student_id) AS students_count
FROM info.courses c
INNER JOIN info.enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY students_count DESC;
---LOGIC USED:
--> Using JOIN to combine courses with enrollments.
--> Using COUNT() to count distinct students per course.
--> Using GROUP BY to group results by course.
--> Using ORDER BY to list courses with the highest enrollments first.

-- 3) Find the names of students who have not enrolled in any course
SELECT s.first_name,
       s.last_name,
       s.student_id
FROM info.students s
LEFT JOIN info.enrollments e
ON s.student_id = e.student_id
WHERE e.course_id IS NULL;
---LOGIC USED:
--> Using LEFT JOIN to include all students even if they are not enrolled.
--> Using WHERE IS NULL to filter students with no course enrollments.

-- 4) Retrieve student names along with the courses they are enrolled in
SELECT s.student_id,
       s.first_name,
       s.last_name,
       c.course_name 
FROM info.students s
INNER JOIN info.enrollments e
ON s.student_id = e.student_id
INNER JOIN info.courses c
ON e.course_id = c.course_id;
---LOGIC USED:
--> Using multiple INNER JOINs to fetch student and course details.

-- 5) List teacher names and the courses they are assigned to
SELECT t.teacher_id,
       t.first_name,
       t.last_name,
       c.course_name
FROM info.teachers t
INNER JOIN info.courses c
ON t.teacher_id = c.teacher_id;
---LOGIC USED:
--> Using INNER JOIN to retrieve only teachers assigned to courses.

-- 6) Retrieve a list of students and their enrollment dates for a specific course
SELECT s.first_name,
       s.last_name,
       c.course_name,
       e.enrollment_date
FROM info.students s
INNER JOIN info.enrollments e
ON s.student_id = e.student_id
INNER JOIN info.courses c
ON e.course_id = c.course_id
WHERE LOWER(c.course_name) = 'machine learning';
---LOGIC USED:
--> Using INNER JOINs to get students and their enrolled courses.
--> Using WHERE LOWER() to ensure case-insensitive matching for course name.

-- 7) Find the names of students who have not made any payments
SELECT s.student_id,
       s.first_name,
       s.last_name
FROM info.students s
LEFT JOIN info.payments p
ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;
---LOGIC USED:
--> Using LEFT JOIN to include all students even if they haven't paid.
--> Using WHERE IS NULL to filter students who haven't made any payments.

-- 8) Identify courses that have no enrollments
SELECT c.course_name,
       c.course_id
FROM info.courses c
LEFT JOIN info.enrollments e
ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;
---LOGIC USED:
--> Using LEFT JOIN to include all courses even if they have no enrollments.
--> Using WHERE IS NULL to filter courses with no student enrollments.

-- 9) Identify students who are enrolled in more than one course
-- Method 1:
SELECT s.student_id,
       s.first_name,
       s.last_name,
       COUNT(e.course_id) AS no_of_courses_enrolled
FROM info.students s
INNER JOIN info.enrollments e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1
ORDER BY no_of_courses_enrolled DESC;

-- Method 2:
SELECT e1.student_id, 
       s.first_name, 
       s.last_name, 
       COUNT(DISTINCT e1.course_id) AS no_of_courses_enrolled
FROM info.enrollments e1
JOIN info.enrollments e2
ON e1.student_id = e2.student_id 
AND e1.course_id <> e2.course_id 
JOIN info.students s 
ON e1.student_id = s.student_id
GROUP BY e1.student_id, s.first_name, s.last_name
HAVING COUNT(DISTINCT e1.course_id) > 1
ORDER BY no_of_courses_enrolled DESC;
---LOGIC USED:
--> Using self-join to compare different course enrollments for the same student.
--> Using COUNT() with DISTINCT to count unique courses per student.
--> Using HAVING to filter students enrolled in more than one course.
--> Ordering results in descending order based on course count.

-- 10) Find teachers who are not assigned to any courses
SELECT t.teacher_id, 
       t.first_name,
       t.last_name
FROM info.teachers t
LEFT JOIN info.courses c
ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;
---LOGIC USED:
--> Using LEFT JOIN to include all teachers.
--> Using WHERE IS NULL to filter teachers not assigned to any course.
