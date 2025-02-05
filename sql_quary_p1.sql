-- sql retail sales analysis - p1



-- create table
CREATE TABLE retail_sales
            (
               transactions_id INT PRIMARY KEY,
               sale_date DATE,	
               sale_time TIME,
               customer_id INT,
               gender VARCHAR(10),
               age INT,
               category VARCHAR(15),
               quantiy INT,
               price_per_unit FLOAT,
               cogs FLOAT,
               total_sale FLOAT	
             )

SELECT * FROM RETAIL_SALES;

SELECT 
     COUNT(*)
	 FROM RETAIL_SALES;

SELECT * FROM RETAIL_SALES
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL 
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR 
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR 
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

-- DELETE NULL ROW
DELETE FROM RETAIL_SALES
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL 
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR 
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR 
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

-- Data Exploration

-- How Many Sales We Have ?
SELECT COUNT (*) AS total_sale
FROM RETAIL_SALES;

-- How Many Customers We Have ?
SELECT COUNT (*) AS customer_id
FROM  RETAIL_SALES;

-- How Many UNIUQUE Customers We Have ?
SELECT COUNT(DISTINCT customer_id ) 
FROM  RETAIL_SALES;

-- How Many uniuque cetagory we have ?
SELECT DISTINCT category
FROM RETAIL_SALES;

-- Data Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM RETAIL_SALES
WHERE sale_date ='2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022	 
SELECT *
FROM RETAIL_SALES
WHERE category = 'Clothing'
       AND
	  TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	  AND
	  quantiy >= 4

--Q.3 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
AVG(age)
FROM RETAIL_SALES
WHERE category ='Beauty';
	  
--Q.4 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
SUM(total_sale)AS Net_sales,
COUNT(total_sale)AS Total_Orde
FROM RETAIL_SALES
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM RETAIL_SALES
WHERE total_sale >1000;

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender
,COUNT(GENDER) AS total_transactions
FROM RETAIL_SALES
GROUP BY category,gender
ORDER BY 1;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
      year,
	  month,
	  avg_sale
FROM 
(
SELECT
 EXTRACT(YEAR FROM sale_date)AS year,
 EXTRACT(MONTH FROM sale_date)AS month,
 AVG(total_sale)AS avg_sale,
 RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC)as rank
 FROM RETAIL_SALES
 GROUP BY 1,2
)as t1 
WHERE RANK =1
 -- Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
SUM(total_sale)
FROM RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
COUNT(DISTINCT customer_id)AS CNT_UNIQUE_CS
FROM RETAIL_SALES
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
CASE
   WHEN EXTRACT (HOUR FROM sale_time)< 12 THEN 'MORNING'
   WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
   ELSE 'EVENING'
   END AS shift
FROM RETAIL_SALES
)
SELECT
     shift,
COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
	 
-- END OF PROJECT
