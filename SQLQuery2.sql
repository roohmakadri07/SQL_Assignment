USE Northwind
GO

CREATE TABLE dbo.salesman
(
	salesman_id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	commission float NOT NULL
)



INSERT INTO dbo.salesman VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12)


SELECT * FROM dbo.salesman


CREATE TABLE dbo.customer
(
	customer_id int PRIMARY KEY,
	cust_name varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	grade int,
	salesman_id int
)


ALTER TABLE dbo.customer
ADD CONSTRAINT FK_customer_salesmanId FOREIGN KEY (salesman_id)
REFERENCES salesman (salesman_id)


INSERT INTO dbo.customer VALUES
(3002,'Nick Rimando','New York',100,5001),
(3007,'Brad Davis','New York',200,5001),
(3005,'Graham Zusi','California',200,5002),
(3008,'Julian Green','London',300,5002),
(3004,'Fabian Johnson','Paris',300,5006),
(3009,'Geoff Cameron','Berlin',100,5003),
(3003,'Jozy Altidor','Moscow',200,5007)

SELECT * from dbo.customer


CREATE TABLE dbo.orders
(
	ord_no int PRIMARY KEY,
	purch_amt int NOT NULL,
	ord_date date NOT NULL,
	customer_id int,
	salesman_id int
)

ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_customerId FOREIGN KEY (customer_id)
REFERENCES customer (customer_id)

ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_salesmanId FOREIGN KEY (salesman_id)
REFERENCES salesman (salesman_id)


INSERT INTO dbo.orders VALUES
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.50,'2012-08-17',3009,5003),
(70005,2400.60,'2012-07-27',3007,5001),
(70008,5760.00,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.40,'2012-10-10',3009,5003),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.60,'2012-04-25',3002,5001),
(70001,150.50,'2012-10-05',3005,5002),
(70007,948.50,'2012-09-10',3005,5002),
(70012,250.45,'2012-06-27',3008,5002)

SELECT * FROM dbo.orders


-- QUERY 01
SELECT salesman.name AS salesman_name, customer.cust_name, customer.city
FROM dbo.salesman, dbo.customer
WHERE customer.city = salesman.city



-- QUERY 02
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM dbo.orders o
INNER JOIN dbo.customer c
ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000



-- QUERY 03
SELECT c.cust_name, c.city, s.name AS salesman_name, s.commission
FROM dbo.customer c
INNER JOIN dbo.salesman s
ON c.salesman_id = s.salesman_id



-- QUERY 04
SELECT c.cust_name, c.city, s.name AS salesman_name, s.commission
FROM dbo.customer c
INNER JOIN dbo.salesman s
ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12



-- QUERY 05
SELECT c.cust_name, c.city, s.name AS salesman_name, s.commission
FROM dbo.customer c
INNER JOIN dbo.salesman s
ON c.salesman_id = s.salesman_id
WHERE (c.city != s.city) AND (s.commission > 0.12)


-- QUERY 06
SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.name AS salesman_name, s.commission
FROM dbo.orders o
INNER JOIN dbo.customer c
ON o.customer_id = c.customer_id
INNER JOIN dbo.salesman s
ON o.salesman_id = s.salesman_id


-- QUERY 07
SELECT * 
FROM orders 
NATURAL JOIN customer  
NATURAL JOIN salesman


-- QUERY 08
SELECT c.cust_name, c.city, c.grade, s.name AS salesman_name, s.city
FROM dbo.customer c
LEFT JOIN dbo.salesman s
ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id


-- QUERY 09
SELECT c.cust_name, c.city, c.grade, s.name AS salesman_name, s.city
FROM dbo.customer c
LEFT JOIN dbo.salesman s
ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id


-- QUERY 10
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM dbo.customer c
LEFT JOIN dbo.orders o
ON c.customer_id = o.customer_id
ORDER BY o.ord_date


-- QUERY 11
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name AS salesman_name, s.commission
FROM dbo.customer c
LEFT JOIN dbo.orders o
ON c.customer_id = o.customer_id
LEFT JOIN dbo.salesman s
ON c.salesman_id = s.salesman_id



-- QUERY 12
SELECT s.name AS salesman_name, c.cust_name, c.city
FROM dbo.salesman s
LEFT JOIN dbo.customer c
ON s.salesman_id = c.salesman_id
ORDER BY s.salesman_id



-- QUERY 13
SELECT s.name AS salesman_name, c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt
FROM dbo.orders o
LEFT JOIN dbo.salesman s
ON o.salesman_id = s.salesman_id
LEFT JOIN dbo.customer c
ON o.customer_id = c.customer_id
ORDER BY s.salesman_id



-- QUERY 14
SELECT s.name AS salesman_name, c.cust_name, c.grade, o.ord_no, o.purch_amt
FROM dbo.salesman s
LEFT JOIN dbo.customer c
ON s.salesman_id = c.salesman_id
LEFT JOIN dbo.orders o
ON s.salesman_id = o.salesman_id
AND c.customer_id = o.customer_id
WHERE o.purch_amt >= 2000 AND c.grade IS NOT NULL



-- QUERY 15
SELECT s.name AS salesman_name, c.cust_name, c.grade, o.ord_no, o.purch_amt
FROM dbo.salesman s
LEFT JOIN dbo.customer c
ON s.salesman_id = c.salesman_id
LEFT JOIN dbo.orders o
ON s.salesman_id = o.salesman_id
AND c.customer_id = o.customer_id
WHERE o.purch_amt >= 2000 AND c.grade IS NOT NULL



-- QUERY 16
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM dbo.customer c
FULL JOIN dbo.orders o
ON c.customer_id = o.customer_id



-- QUERY 17
SELECT *
FROM dbo.salesman
CROSS JOIN dbo.customer




-- QUERY 18
SELECT *
FROM dbo.salesman
CROSS JOIN dbo.customer
WHERE salesman.city IS NOT NULL



-- QUERY 19
SELECT *
FROM dbo.salesman
CROSS JOIN dbo.customer
WHERE (salesman.city IS NOT NULL) AND (customer.grade IS NOT NULL)



-- QUERY 20
SELECT *
FROM dbo.salesman s
CROSS JOIN dbo.customer c
WHERE (s.city IS NOT NULL) AND (s.city != c.city) AND (c.grade IS NOT NULL)