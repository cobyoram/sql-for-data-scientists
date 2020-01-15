-- Joins, aggregation, and UNION
SELECT * FROM dept
UNION
SELECT * FROM dept2;

SELECT deptno, dname FROM dept
UNION
SELECT deptno, dname FROM dept2;

--keep duplicates
SELECT locno FROM dept
UNION ALL
SELECT locno FROM dept2;

--drop duplicates
SELECT locno FROM dept
UNION
SELECT locno FROM dept2; 

--Order by goes after unioning... DUH!
SELECT * FROM dept
WHERE locno <> 50
UNION
SELECT * FROM dept2
WHERE locno<> 50
ORDER BY deptno; 

