-- START

SELECT *
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;

SELECT ename, empno, emp.deptno, dname
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;

SELECT ename, empno, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;

SELECT ename, empno, emp.deptno, dname
FROM dept LEFT OUTER JOIN emp
ON emp.deptno = dept.deptno;

