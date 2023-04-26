-- COMMON TABLE EXPRESSION ALSO KNOWN AS CTE

-- WE HAVE TWO TYPES CTE 
-- NON-RECURSIVE AND RECURSIVE 

-- NON-RECURSIVE CTE : that references itself only once in its definition

-- RECURSIVE CTE : IT HAS A REFERENCE TO ITSELF, IT CAN JOIN MULTIPLE TABLES TO ITSELF TO PROCESS 
-- HIERACHICAL DATA IN THE TABLE.

-- WE ARE FOCUSING ON RECURSIVE CTE

-- RECURSIVE CTE SYNTAX 

WITH CTE_NAME AS(

SELECT column_name

FROM table_name
)
SELECT column_name

FROM CTE_NAME;

-- EXAMPLES

-- LET US GET THE AVG OF SALES FROM THE FINANCIAL TABLE USING CTE

WITH Avg_sales AS(

SELECT segment, ROUND(AVG(sales),2) AS "Avg_sale"
FROM financial_sample.`financial samples`
GROUP BY Segment
)
SELECT segment, Avg_sale
FROM Avg_sales ;

-- THE BEST WAY TO FIND RANKS IS BY USING CTE  THAT IS USING A WINDOW FUNCTIONS

-- WE CAN PERFORM WINDOW FUNCTIONS USING CTE , YOU CAN PERFORM ANY TYPE OF WINDOW FUNCTIONS USING CTE 

-- JUST KNOW THAT YOUR CTE CODE CAN RUN ON ITS OWN SO IT IS IMPORTANT TO TEST RUN YOUR CTE CODE BEFORE CALLING IT

WITH Rank_sales AS (

SELECT segment, ROUND(SUM(sales),2) AS "Total_sales",

DENSE_RANK () OVER ( PARTITION BY segment
ORDER BY SUM(sales) DESC) AS ranks
FROM financial_sample.`financial samples`
GROUP BY segment

)
SELECT segment, Total_sales -- ranks -- YOU CAN CALL THE RANK OR YOU CAN IGNORE IT SO FOR ME I WILL IGNORE IT
FROM Rank_sales
ORDER BY Total_sales DESC;

-- SO LET ME SHOW HOW TO USE JOIN IN CTE 
-- YOU CAN JOIN AS MANY TABLE AS YOU CAN BUT ALWAYS LOOK OUT TO USE THE UNIQUE IDENTIFIERS

-- I WILL CREATE A SYNTAX ON HOW TO GO ABOUT IT 

WITH Join_tables AS (

SELECT column_name,                  

DENSE_RANK () OVER ( PARTITION BY column_name 
ORDER BY column_name  ) AS ranks           -- YOU CAN USE ANY WINDOW FUNCTION OR ANY FUNCTION OF YOUR CHOICE IT CAN BE CASE, TIME ETC.

FROM table_name AS t1
INNER JOIN table_name AS t2                -- ANY JOIN THAT IS REQUIRED FOR THE PARTICULAR TASK
ON
t1.column_name_unique_identifier = t2.column_name_unique_identifier

INNER JOIN  table_name AS t3
ON
t1.column_name_unique_identifier = t3.column_name_unique_identifier

GROUP BY column_name 
)

SELECT j.column_name

FROM Join_tables AS j
INNER JOIN  table_name AS t4                      -- YOU CAN PERFORM JOIN EVEN AFTER THE CTE 
ON 
j.column_name_unique_identifier = t4.column_name_unique_identifier
ORDER BY column_name ;


-- NESTED RECURSIVE CTE

-- Nested CTE create multiple cte functions
-- But the second query works to the first query

-- This is a basic syntaxs for a Nested CTE, you can perform multiple joins and functions




WITH cte_name1 AS (
SELECT column_names

FROM table_names
),
cte_name2 AS (
SELECT  cte1.column_names
FROM cte_name1 AS cte1
)
SELECT cte2.column_names
FROM cte_names;


WITH Sum_sales AS(
SELECT segment , SUM(sales) AS "Total_sales" -- The first CTE computes the total sum of sales by each segment
FROM financial_sample.`financial samples`
GROUP BY segment
),
Avg_sales AS ( 
SELECT s.segment , AVG(s.Total_sales) AS "Avg_total_sales" -- The second CTE computes the segment level average
FROM Sum_sales AS s
GROUP BY segment
)
SELECT segment , AVG( Avg_total_sales) AS "Overall_average" -- The third CTE computes the overall average
FROM Avg_sales
GROUP BY segment






