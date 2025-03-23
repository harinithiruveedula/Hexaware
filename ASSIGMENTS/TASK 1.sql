-----creating a database
create database SISDB;

--selecting the created database
use SISDB;

------------------------------------------TASK 1--------------------------------------------------------
---------------------------------------DATA BASE DESIGN-----------------------------------------------
--------------------------------------CREATING THE TABLES-----------------------------------------------

--creating students table
create table students (
    student_id int identity(1,1) primary key,
    first_name nvarchar(20) not null,
    last_name nvarchar(20) not null,
    date_of_birth date not null,
    email varchar(30) unique not null,
    phone_number nvarchar(15) unique not null  
);

--creating teachers table
create table teachers (
    teacher_id int identity(1,1) primary key,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    email varchar(50) not null unique
);

--creating courses table
create table courses (
    course_id int identity(1,1) primary key,
    course_name varchar(50) not null,
    credits int not null,
    teacher_id int,
    foreign key (teacher_id) references teachers(teacher_id) on delete set null
);

--creating enrollments table
create table enrollments (
    enrollment_id int identity(1,1) primary key,
    student_id int not null,
    course_id int not null,
    enrollment_date date not null default getdate(),
    foreign key(student_id) references students(student_id) on delete cascade,
	--ON DELETE CASCADE:
	            -- it autonatically deletes the data when data in student table is delted
				--it is to maintain DATA INTEGRITY
    foreign key(course_id) references courses(course_id) on delete cascade
);

--creating payments table
create table payments (
    payment_id int identity(1,1) primary key,
    student_id int not null,
    amount decimal(10,2) not null,
    payment_date date not null,
    foreign key (student_id) references students(student_id) on delete cascade
);

---------------------------------------INSERTING VALUES---------------------------------------

--students table
insert into students (student_id, first_name, last_name, date_of_birth, email, phone_number)
values 
(1, 'harini', 'thiruveedula', '1998-05-10', 'harini.thiruveedula@gmail.com', '9876543210'),
(2, 'rekha', 'iyer', '1997-07-22', 'rekha.iyer@gmail.com', '8765432109'),
(3, 'hari', 'krishna', '1996-03-15', 'hari.krishna@gmail.com', '7654321098'),
(4, 'prthu', 'reddy', '1999-11-05', 'prthu.reddy@gmail.com', '6543210987'),
(5, 'dharani', 'pillai', '2000-09-25', 'dharani.pillai@gmail.com', '5432109876'),
(6, 'pravallika', 'gowda', '1998-02-18', 'pravallika.gowda@gmail.com', '4321098765'),
(7, 'asha', 'nair', '1997-06-30', 'asha.nair@gmail.com', '3210987654'),
(8, 'akhil', 'sharma', '1999-01-08', 'akhil.sharma@gmail.com', '2109876543'),
(9, 'jay', 'patel', '1996-12-12', 'jay.patel@gmail.com', '1098765432'),
(10, 'visali', 'joshi', '1998-04-04', 'visali.joshi@gmail.com', '9988776655');


--teachers table
insert into teachers (teacher_id, first_name, last_name, email) 
values 
(1, 'amit', 'sharma', 'amit.sharma@gmail.com'),
(2, 'neha', 'verma', 'neha.verma@gmail.com'),
(3, 'rajesh', 'gupta', 'rajesh.gupta@gmail.com'),
(4, 'priya', 'reddy', 'priya.reddy@gmail.com'),
(5, 'suresh', 'nair', 'suresh.nair@gmail.com'),
(6, 'pooja', 'iyer', 'pooja.iyer@gmail.com'),
(7, 'vikram', 'menon', 'vikram.menon@gmail.com'),
(8, 'meera', 'patil', 'meera.patil@gmail.com'),
(9, 'arjun', 'chopra', 'arjun.chopra@gmail.com'),
(10, 'kavita', 'das', 'kavita.das@gmail.com');


--courses table
insert into courses (course_name, credits, teacher_id)
values 
('computer science basics', 4, 1),
('mathematics for engineers', 3, 2),
('advanced java programming', 4, 3),
('physics fundamentals', 3, 4),
('artificial intelligence', 4, 5),
('data structures & algorithms', 3, 6),
('cyber security', 4, 7),
('big data analytics', 3, 8),
('cloud computing', 4, 9),
('machine learning', 4, 10);

--enrollments table 
insert into enrollments (student_id, course_id, enrollment_date)
values 
(1, 1, '2021-06-05'),
(1, 2, '2021-06-10'),
(1, 3, '2021-06-15'),
(1, 4, '2021-06-20'),
(1, 5, '2021-06-25'),
(2, 6, '2021-07-01'),
(2, 7, '2021-07-05'),
(2, 8, '2021-07-10'),
(2, 9, '2021-07-15'),
(2, 10, '2021-07-20'),
(3, 1, '2021-06-06'),
(3, 3, '2021-06-11'),
(3, 5, '2021-06-16'),
(3, 7, '2021-06-21'),
(3, 9, '2021-06-26'),
(4, 2, '2021-07-02'),
(4, 4, '2021-07-06'),
(4, 6, '2021-07-11'),
(4, 8, '2021-07-16'),
(4, 10, '2021-07-21'),
(5, 1, '2021-06-07'),
(5, 2, '2021-06-12'),
(5, 3, '2021-06-17'),
(5, 4, '2021-06-22'),
(5, 5, '2021-06-27'),
(6, 6, '2021-07-03'),
(6, 7, '2021-07-07'),
(6, 8, '2021-07-12'),
(6, 9, '2021-07-17'),
(6, 10, '2021-07-22'),
(7, 1, '2021-06-08'),
(7, 3, '2021-06-13'),
(7, 5, '2021-06-18'),
(7, 7, '2021-06-23'),
(7, 9, '2021-06-28'),
(8, 2, '2021-07-04'),
(8, 4, '2021-07-08'),
(8, 6, '2021-07-13'),
(8, 8, '2021-07-18'),
(8, 10, '2021-07-23'),
(9, 1, '2021-06-09'),
(9, 2, '2021-06-14'),
(9, 3, '2021-06-19'),
(9, 4, '2021-06-24'),
(9, 5, '2021-06-29'),
(10, 6, '2021-07-05'),
(10, 7, '2021-07-09'),
(10, 8, '2021-07-14'),
(10, 9, '2021-07-19'),
(10, 10, '2021-07-24');


--payments table 
insert into payments (student_id, amount, payment_date)
values 
(1, 125000.00, '2021-06-06'),
(2, 130500.00, '2021-06-11'),
(3, 145750.00, '2021-06-16'),
(4, 160000.00, '2021-06-21'),
(5, 175000.00, '2021-06-26'),
(6, 110250.00, '2021-07-02'),
(7, 140000.00, '2021-07-06'),
(8, 155000.00, '2021-07-11'),
(9, 167500.00, '2021-07-16'),
(10, 180000.00, '2021-07-21');

----------------------------viewing all tables----------------------------------
select * from students;
select * from teachers;
select * from courses;
select * from enrollments;
select * from payments;
