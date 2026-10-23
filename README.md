Data Transformer
About
Data Transformer is a small MySQL project for practicing SQL joins, subqueries, date and string functions, window functions, and CASE statements.
Tables
- Customers: customer name, email, and registration date
- Orders: customer order date and amount
- Employees: department, hire date, and salary
What I practiced
- INNER JOIN, LEFT JOIN, RIGHT JOIN, and a FULL OUTER JOIN alternative
- Subqueries using AVG()
- Date functions such as YEAR(), MONTH(), DATEDIFF(), and DATE_FORMAT()
- String functions such as CONCAT(), REPLACE(), UPPER(), LOWER(), and TRIM()
- Window functions SUM() OVER() and RANK() OVER()
- CASE statements for discounts and salary categories
How to run
1. Open MySQL Workbench or another MySQL editor.
2. Open data_transformer.sql.
3. Run the script from the top.
4. Check the result grid after each SELECT query.
Assumptions
- The project uses MySQL 8.0 or later for window functions.
- MySQL does not support FULL OUTER JOIN directly, so the script uses LEFT JOIN and RIGHT JOIN with UNION.
- Discount values are shown as amounts, not final prices.
- Salary categories use these simple limits: High = 55,000 or more; Medium = 45,000 to 54,999.99; Low = below 45,000.
- Sample records are made for practice.
