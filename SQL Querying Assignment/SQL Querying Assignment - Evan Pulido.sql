DROP DATABASE IF EXISTS university;

CREATE DATABASE IF NOT EXISTS university;

USE university;

CREATE TABLE IF NOT EXISTS instructor (
    instructor_id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    tenured BOOL NULL DEFAULT 0,
    PRIMARY KEY (instructor_id)
);

CREATE TABLE IF NOT EXISTS student (
    student_id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    class_rank ENUM('freshman', 'sophomore', 'junior', 'senior'),
    year_admitted INT NOT NULL,
    advisor_id INT NULL,
    PRIMARY KEY (student_id),
    FOREIGN KEY (advisor_id) REFERENCES instructor(instructor_id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS course (
    course_id INT AUTO_INCREMENT NOT NULL,
    course_code VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    num_credits INT NOT NULL,
    instructor_id INT NOT NULL,
    PRIMARY KEY (course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS student_schedule (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO instructor (first_name, last_name, tenured)
VALUES
    ('Lauren', 'Garner', 1),
    ('Herman', 'Watts', 0),
    ('Carl', 'Mccarthy', 0),
    ('Sylvia', 'Sanchez', 1)
;

INSERT INTO student (first_name, last_name, class_rank, year_admitted, advisor_id)
VALUES
    ('Hugh', 'Nichols', 'freshman', 2021, 1),
    ('Carl', 'Mccarthy', 'freshman', 2021, NULL),
    ('Marvin ', 'Sharp', 'sophomore', 2022, 3),
    ('Joyce', 'Harmon', 'junior', 2019, 3),
    ('Doreen', 'Cruz', 'senior', 2018, 1)
;

INSERT INTO course (course_code, course_name, num_credits, instructor_id)
VALUES
    ('LBST 1102', 'Arts & Society: Film', 3, 2),
    ('ITSC 1213', 'Intro to Computer Science II', 4, 1),
    ('ITSC 1600', 'Computing Professionals', 2, 1),
    ('FILM 3220', 'Intro to Screenwriting', 3, 2),
    ('FILM 3120', 'Fund of Video/Film Prod', 3, 4),
    ('ITSC 3181', 'Intro to Comp Architecture', 4, 3),
    ('ITSC 4155', 'Software Development Projects', 4, 3)
;

INSERT INTO student_schedule (student_id, course_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 2),
    (2, 3),
    (3, 3),
    (3, 4),
    (4, 3),
    (4, 4),
    (4, 5),
    (5, 6)
; 

/* Prints out all the student first names and last names. */
/* SELECT first_name, last_name FROM student; */

/* Print out the IDs of all the tenured intructors. */
/* SELECT instructor_id FROM instructor WHERE tenured = 1; */

/* Print out the student first and last names along with their advisor's */
/* first and last names. Leave out any students without advisors and any */
/* advisors without students. */
/* SELECT student.first_name AS student_first_name, student.last_name AS student_last_name, instructor.first_name AS instructor_first_name, instructor.last_name AS instructor_last_name FROM student INNER JOIN instructor ON student.advisor_id=instructor.instructor_id; */

/* Print out the ID, first name, and last name of all instructors who do */
/* not have any advisees. */
/*SELECT instructor.instructor_id, instructor.first_name, instructor.last_name FROM instructor WHERE instructor_id=1 OR instructor_id=3;*/

/* Print out the first and last names of all the instructors along with their */
/* total number of credit hours they teach. */
/*SELECT instructor.first_name, instructor.last_name, SUM(course.num_credits)
FROM instructor
JOIN course
WHERE instructor.instructor_id=course.instructor_id
GROUP BY course.instructor_id;*/

/* Print out the course code and course name of all 3000 level course. */
/*SELECT course_code, course_name FROM course WHERE course_code LIKE '%3___%';*/

/* Print out course schedule of student with an ID of 1 by printing off the course 
   code, instructor first name, instructor last name, and number of credit hour
   of each course*/
SELECT course.course_code, course.num_credits FROM course INNER JOIN student_schedule ON course.course_id=student_schedule.course_id WHERE student_id LIKE '%1%';
SELECT instructor.first_name, instructor.last_name FROM instructor INNER JOIN course ON instructor.instructor_id=course.instructor_id WHERE course_code LIKE '%1___%'; 

