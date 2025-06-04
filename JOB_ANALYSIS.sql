CREATE DATABASE PLACEMENT;
USE PLACEMENT;
DROP DATABASE PLACEMENT;
SELECT * FROM placement_data;

-- whatis the overall placement rate

SELECT status,count("placed")
FROM placement_data
GROUP BY status;

--  What is the average MBA score of placed vs non-placed students?

SELECT status,avg(mba_p)
FROM placement_data
GROUP BY status;

-- Which undergraduate specializations have the highest placement rate?

SELECT specialisation,
       COUNT(CASE WHEN status = 'Placed' THEN 1 END) AS placed_count,
       COUNT(*) AS total_students,
       ROUND(100.0 * COUNT(CASE WHEN status = 'Placed' THEN 1 END) / COUNT(*), 2) AS placement_rate
FROM placement_data
GROUP BY specialisation
ORDER BY placement_rate DESC;

--  How does prior work experience impact placement?

SELECT workex,COUNT(CASE WHEN status = 'Placed' THEN 1 END) AS placed_students
,COUNT(*) as total_student
FROM placement_data
GROUP BY workex;

--  Top 5 students with the highest MBA percentage who got placed

SELECT * FROM placement_data
WHERE status="placed"
ORDER BY mba_p DESC
LIMIT 5;
 

-- Correlation between SSC (10th) scores and placement

SELECT 
  CASE 
    WHEN ssc_p >= 80 THEN '80+'
    WHEN ssc_p>= 60 THEN '60-79'
    ELSE '<60'
  END AS ssc_range,
  COUNT(CASE WHEN status = 'Placed' THEN 1 END) AS placed,
  COUNT(*) AS total
FROM placement_data
GROUP BY ssc_range;

SELECT gender, status, COUNT(*) AS count 
FROM placement_data 
GROUP BY gender, status;

--  Average graduation percentage of placed vs not placed

SELECT status , avg(degree_p) AS avg_degree_percent
FROM placement_data
Group by status;

--  Which gender has higher average MBA scores?

SELECT gender , avg(mba_p)
FROM placement_data
GROUP BY gender;

--  Do students with work experience score higher in MBA?

SELECT workex, avg(mba_p)
FROM placement_data
GROUP BY workex;


-- Placement rate by gender

SELECT 
  gender,
  ROUND(100.0*COUNT(CASE WHEN status = 'Placed' THEN 1 END) / COUNT(*), 2) AS placement_rate
FROM placement_data
GROUP BY gender;

-- Which HSC (12th) performance range has highest placement?

SELECT 
  CASE 
    WHEN hsc_p >= 80 THEN '80+'
    WHEN hsc_p >= 60 THEN '60-79'
    ELSE '<60'
  END AS hsc_range,
  COUNT(CASE WHEN status = 'Placed' THEN 1 END) AS placed,
  COUNT(*) AS total
FROM placement_data
GROUP BY hsc_range;






