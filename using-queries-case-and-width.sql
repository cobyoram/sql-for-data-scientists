-- Get the names of all employees with higher salaries than Clark's
-- Outer query - which employees have a greater salary than...
SELECT ename
FROM EMP
WHERE sal >
-- The salary assigned to Clark. 
  (SELECT sal
  FROM emp
  WHERE empno = 7782);
  
  
-- Select employee name, job title, hiredate of all employees
-- in the same department as Clark
SELECT ename, job, hiredate
FROM EMP
WHERE deptno =
-- Get Clark's department number
  (SELECT deptno
  FROM emp
  WHERE empno = 7782);
  
  
-- Who has a salary greater than any clerk?
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ANY
  (SELECT sal
  FROM emp
  WHERE job = 'CLERK' );
-- Some clearks have greater salaries than others, hence the inclusion
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ANY
  (SELECT sal
  FROM emp
  WHERE job = 'CLERK' )
AND job <> 'CLERK';
--Filters those out.
--OOORRRR


-- Salary greater than ALL the clerks B)
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ALL
  (SELECT sal
  FROM emp
  WHERE job = 'CLERK' );
  
  


SELECT empno, ename, sal,
CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW'
END as salary_level
FROM emp
-- Order by ordinal indexing in the SELECT clause
ORDER BY 4, 3 DESC;


-- Using a more complex CASE statement, we can do the same to get percentages 
-- of records that meet some criteria. Let’s say we want to find the 
-- percentage of employees in each category with salaries greater than 1000.
-- By converting the corresponding records to 1’s and 0’s, we can take an
-- average which results in a group percentage: 
SELECT job,
AVG(CASE WHEN sal < 999 THEN 1 WHEN sal > 1000 THEN 0 END) AS pct_lt1000,
AVG(CASE WHEN sal < 999 THEN 0 WHEN sal > 1000 THEN 1 END) AS pct_gt1000
FROM emp
GROUP BY job;

-- using Common Table Expressions (CTEs)
-- Name the CTE
WITH cte AS  
-- Write a regular SQL statement
-- inside parentheses 
  (
    SELECT ename, sal
    FROM emp)
-- "Feed" the CTE into a second query
SELECT
  AVG(sal) AS ave_sal
FROM cte;	


-- Create temporary table title_sal
-- get only results where avg_sal > 1500
WITH title_sal AS 
(
        SELECT job, AVG(sal) AS avg_sal
        FROM emp
        GROUP BY job
)
SELECT * FROM title_sal
        WHERE avg_sal > 1500;
		
-- WhICH is the same thing as::::

-- Another approach -- HAVING
SELECT job, AVG(sal) AS avg_sal
FROM emp
GROUP BY job
HAVING AVG(sal) > 1500;

--BUT
-- Get average of average salary
-- by job title 
WITH avg_title_sal AS 
(
        SELECT job, AVG(sal) AS avg_sal
        FROM emp
        GROUP BY job
)
SELECT AVG(avg_sal) AS avg_title_sal
        FROM avg_title_sal;
		
-- Here we can aggregate an already aggregated expression. Boom. Average of the title averages.	
