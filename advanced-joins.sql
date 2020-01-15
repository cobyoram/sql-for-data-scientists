-- Start

SELECT empno, ename, dept.deptno, dname
FROM dept RIGHT OUTER JOIN emp
ON emp.deptno = dept.deptno;

SELECT empno, ename, emp.deptno, dname
FROM dept LEFT OUTER JOIN emp
ON emp.deptno = dept.deptno;


SELECT empno, ename, emp.deptno, dname, cty, state
FROM emp

LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno

LEFT OUTER JOIN loc
ON dept.locno = loc.locno;


SELECT empno, ename, emp.deptno, dname, cty, state
FROM emp

INNER JOIN dept
ON emp.deptno = dept.deptno

INNER JOIN loc
ON dept.locno = loc.locno;

