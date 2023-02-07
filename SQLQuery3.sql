USE Northwind
GO

CREATE TABLE Department
(
	dept_id int PRIMARY KEY,
	dept_name varchar(20)
)



INSERT INTO Department VALUES
(10,'ACCOUNTING'),
(20,'RESEARCH'),
(30,'SALES'),
(40,'OPERATIONS')


SELECT * FROM Department


CREATE TABLE Employee
(
	emp_id int PRIMARY KEY,
	dept_id int,
	mngr_id int,
	emp_name varchar(20),
	salary int,
	CONSTRAINT FK_emp_deptId FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
)


INSERT INTO Employee VALUES
(7839,10,NULL,'KING',5000),
(7692,30,7839,'BLAKE',2850),
(7782,10,7839,'CLARK',2450),
(7566,20,7839,'JONES',2975),
(7788,20,7566,'SCOTT',3000),
(7902,20,7566,'FORD',3000),
(7369,20,7902,'SMITH',800),
(7499,30,7698,'ALLEN',1600),
(7521,30,7698,'WARD',1250),
(7654,30,7698,'MARTIN',1250),
(7844,30,7698,'TURNER',1500),
(7876,20,7788,'ADAMS',1100),
(7900,30,7698,'JAMES',950),
(7934,10,7782,'MILLER',1300)

SELECT * FROM Employee


-- QUERY 01

SELECT e.emp_name, d.dept_name, e.salary
FROM Employee e
LEFT JOIN Department d
ON e.dept_id = d.dept_id
WHERE (e.salary IN (SELECT MAX(salary) FROM Employee GROUP BY dept_id))




-- QUERY 02

SELECT d.dept_id, d.dept_name, COUNT(e.dept_id) AS [Employee Count]
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(d.dept_name) < 3





-- QUERY 03

SELECT d.dept_id, d.dept_name, COUNT(e.dept_id) AS [Employee Count]
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name




-- QUERY 04

SELECT d.dept_id, d.dept_name, SUM(e.salary) AS [Total Salary]
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name