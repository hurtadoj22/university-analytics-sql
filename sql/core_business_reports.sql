-- =====================================================================
-- UNIVERSITY ERP & ACADEMIC REPORTING SYSTEM
-- Script: core_business_reports.sql
-- Author: Jaime Hurtado
-- Purpose: Analytical queries for administration reporting.
-- =====================================================================

-- 1. Annual Student Enrollment Trends
-- Business Need: The enrollment team requires historical metrics to analyze student volume trends over time.
SELECT 
    COUNT(s.id) AS student_count, 
    YEAR(sc.startdate) AS school_year
FROM student s
INNER JOIN studentcourse sc ON s.id = sc.studentID
GROUP BY YEAR(sc.startdate)
ORDER BY school_year ASC, student_count DESC;


-- 2. Course Offerings Volume by Department
-- Business Need: The Curriculum Committee needs to map course density per department to identify under-resourced areas.
SELECT 
    d.name AS department_name, 
    COUNT(c.id) AS course_count
FROM department d
INNER JOIN course c ON d.id = c.deptID
GROUP BY d.name
ORDER BY course_count ASC, department_name ASC;


-- 3. Course Popularity Analytics
-- Business Need: The recruiting and student success teams need to identify highly demanded courses to optimize scheduling.
SELECT 
    c.name AS course_name, 
    COUNT(s.id) AS student_count
FROM student s
INNER JOIN studentcourse sc ON s.id = sc.studentid
INNER JOIN course c ON sc.courseid = c.id
GROUP BY c.name
ORDER BY student_count DESC, course_name ASC;


-- 4. Operational Compliance Audit: Courses Without Assigned Faculty
-- Business Need: Risk management query to flag active courses missing assigned instructors to prevent scheduling gaps.
SELECT 
    c.name AS unassigned_course_name
FROM course c
LEFT JOIN facultycourse f ON c.id = f.courseId
WHERE f.facultyID IS NULL
ORDER BY c.name ASC;


-- 5. Student Intervention Report: Low Progress Risk
-- Business Need: Identifies students averaging less than 50% progress across academic terms for proactive tutoring outreach.
SELECT 
    s.firstname, 
    s.lastname, 
    ROUND(AVG(sc.progress), 1) AS average_progress
FROM student s
INNER JOIN studentcourse sc ON s.id = sc.studentID
GROUP BY s.id, s.firstname, s.lastname
HAVING AVG(sc.progress) < 50
ORDER BY average_progress DESC, s.firstname ASC, s.lastname ASC;


-- 6. Academic Metrics for Faculty Performance/Bonus Evaluation
-- Business Need: Aggregates average student progress metrics by course to assist HR in evaluating bonus qualifications.
SELECT 
    c.name AS course_name, 
    ROUND(AVG(sc.progress), 1) AS average_progress
FROM course c
INNER JOIN studentcourse sc ON c.id = sc.courseid
GROUP BY c.name
ORDER BY average_progress DESC, course_name ASC;


-- 7. Dual Metric Student Grade Distribution Mapping
-- Business Need: Evaluates students based on their minimum and maximum performance vectors across all registered coursework.
SELECT 
    s.firstname, 
    s.lastname, 
    CASE 
        WHEN MIN(sc.progress) < 40 THEN 'F'
        WHEN MIN(sc.progress) < 50 THEN 'D'
        WHEN MIN(sc.progress) < 60 THEN 'C'
        WHEN MIN(sc.progress) < 70 THEN 'B'
        ELSE 'A'
    END AS minimum_grade,
    CASE 
        WHEN MAX(sc.progress) < 40 THEN 'F'
        WHEN MAX(sc.progress) < 50 THEN 'D'
        WHEN MAX(sc.progress) < 60 THEN 'C'
        WHEN MAX(sc.progress) < 70 THEN 'B'
        ELSE 'A'
    END AS maximum_grade
FROM student s
INNER JOIN studentcourse sc ON s.id = sc.studentid
GROUP BY s.id, s.firstname, s.lastname
ORDER BY minimum_grade DESC, maximum_grade DESC, s.firstname ASC, s.lastname ASC;
