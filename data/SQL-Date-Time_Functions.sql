###############################################################
###############################################################
-- Guided Project: SQL Date-Time Functions
###############################################################
###############################################################


#############################
-- Task One: Getting Started
-- In this task, we will retrieve data from the tables in the
-- employees database
#############################

-- 1.1: Retrieve all the data in the employees, sales, dept_manager, salaries table


#############################
-- Task Two: Current Date & Time
-- In this task, we will learn how to use a number of functions 
-- that return values related to the current date and time. 
#############################

-- 2.1: Retrieve the current date


-- 2.2: Retrieve the current time


-- 2.3: Retrieve the current timestamp


-- 2.4: Retrieve the current date, current date, time, and timestamp
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIME(1), CURRENT_TIME(3), CURRENT_TIMESTAMP;

-- 2.5: Retrieve the time of the day
SELECT transaction_timestamp();
SELECT timeofday();
SELECT now();

#############################
-- Task Three: AGE() - Part One
-- In this task, we will learn how to use the AGE() function to subtract arguments, 
-- producing a "symbolic" result that uses years and months
#############################

-- 3.1: Check the difference between February 28th, 2021 and December 31st, 2019


-- 3.2: How old is the Batman movie that was released March 30, 1939


-- 3.3: Retrieve a list of the current age of all employees
SELECT * FROM employees;


-- 3.4: Retrieve a list of all employees ages as at when they were employed


-- 3.5: Retrieve a list of how long a manager worked at the company


-- 3.6: Retrieve a list of how long a manager have been working at the company
SELECT emp_no, AGE(CURRENT_DATE, from_date) AS Age
FROM dept_manager
WHERE emp_no IN ('110039', '110114', '110228', '110420', '110567', '110854', '111133', '111534','111939');


#############################
-- Task Four: AGE() - Part Two
-- In this task, we will learn how the AGE() function to subtract arguments, 
-- producing a "symbolic" result that uses years and months
#############################

-- 4.1: Retrieve a list of how long a manager worked at the company


-- 4.2: Retrieve a list of how long it took to ship a product to a customer
SELECT * FROM sales;


-- 4.3: Retrieve all the data from the salaries table
SELECT * FROM salaries;


-- 4.4: Retrieve a list of the first name, last name, salary 
-- and how long the employee earned that salary


-- A better result
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date,
CASE
	WHEN AGE(to_date, from_date) < AGE(CURRENT_DATE, from_date) THEN AGE(to_date, from_date)
	ELSE AGE(CURRENT_DATE, from_date)
END 
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

#############################
-- Task Five: EXTRACT() - Part One
-- In this task, we will see how the EXTRACT() function 
-- to retrieve subfields like year or hour from date/time values
#############################

-- 5.1: Extract the day of the month from the current date


-- 5.2: Extract the day of the week from the current date


-- 5.3: Extract the hour of the day from the current date


-- 5.4: What do you think this result will be?
SELECT EXTRACT(DAY FROM DATE('2019-12-31'));

-- 5.5: What do you think this result will be?
SELECT EXTRACT(YEAR FROM DATE('2019-12-31'));

-- 5.6: What about this one?
SELECT EXTRACT(MINUTE from '084412'::TIME);

-- 5.7: Retrieve a list of the ship mode and how long (in seconds) it took to ship a product to a customer


-- 5.8: Retrieve a list of the ship mode and how long (in days) it took to ship a product to a customer
SELECT order_line, order_date, ship_date, 
(EXTRACT(DAY FROM ship_date) - EXTRACT(DAY FROM order_date)) AS days_taken
FROM sales
ORDER BY days_taken DESC;

-- 5.9: Retrieve a list of the current age of all employees


-- 5.10: Retrieve a list of the current age of all employees
SELECT first_name, last_name, birth_date, 
(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) || ' years' AS emp_age
FROM employees;

#############################
-- Task Six: EXTRACT() - Part Two
-- In this task, we will see how the EXTRACT() function 
-- to retrieve subfields like year or hour from date/time values
#############################

-- 6.1: Retrieve a list of all employees ages as at when they were employed


-- 6.2: Retrieve a list of all employees who were 25 or less than 25 years as at when they were employed
SELECT first_name, last_name, birth_date, hire_date, 
(EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) AS Employed_25
FROM employees
WHERE (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) <= 25;

-- 6.3: How many employees were 25 or less than 25 years as at when they were employed


-- 6.4: What do you think will be the result of this query?
SELECT (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) || ' years' AS Age_group,
COUNT((EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date))) AS Num_Employed
FROM employees
WHERE (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) <= 25
GROUP BY age_group
ORDER BY age_group;

-- 6.5: Retrieve all data from the sales table
SELECT * FROM sales;

-- 6.6: Retrieve a list of the product_id, the month of sales and sales
-- for chair sub category in the year 2015


-- 6.7: Retrieve a list of the month of sales and sum of sales
-- for each month for chair sub category in the year 2015



#############################
-- Task Seven: Converting Date to Strings
-- In this task, we will see how to convert dates to strings
#############################

-- 7.1: Change the order date in the sales table to strings


-- 7.2: Change the order date in the sales table to strings


-- 7.3: Change the order date in the sales table to strings


-- 7.4: What do you think will be the result of this?
SELECT order_date, TO_CHAR(order_date, 'Month DAY, YYYY')
FROM sales;

-- 7.5: What do you think will be the result of this?
SELECT *, TO_CHAR(hire_date, 'Day, Month DD YYYY') AS hired_date
FROM employees;

-- 7.6: Retrieve a list of the month of sales and sum of sales
-- for each month for chair sub category in the year 2015


-- 7.7: Retrieve a list of the month of sales and sum of sales
-- for each month in the right order for chair sub category in the year 2015


-- 7.8: Add a currency (dollars) to the sum of monthly sales
SELECT EXTRACT(MONTH FROM ship_date) AS sales_month, 
TO_CHAR(ship_date, 'Month') AS full_sales_month, TO_CHAR(SUM(sales), 'L99999.99') AS monthly_total
FROM sales
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%'
GROUP BY full_sales_month, sales_month
ORDER BY sales_month;

#############################
-- Task Eight: Converting Strings to Date
-- In this task, we will see how to convert strings to dates
#############################

-- 8.1: Change '2019/12/31' to the correct date format


-- 8.2: Change '20191231' to the correct date format


-- 8.3: Change '191231' to the correct date format


-- 8.4: What do you think will be the result of this?
SELECT TO_DATE('123119', 'MMDDYY');

-- 8.5: Retrieve all the data from the employees table
SELECT * FROM employees;

-- Start transaction
BEGIN;

ALTER TABLE employees
ALTER COLUMN hire_date TYPE CHAR(10);

SELECT * FROM employees;

-- Change the hire_date to a correct date format


-- End the transaction
ROLLBACK;
