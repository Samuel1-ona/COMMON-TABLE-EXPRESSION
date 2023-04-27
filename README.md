# COMMON-TABLE-EXPRESSION
a named temporary result set that exists within the scope of a single statement and that can be referred to later within that statement, possibly multiple times.

A Common Table Expression (CTE) is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. CTEs are defined within the execution scope of a single SELECT, INSERT, UPDATE, or DELETE statement.

There are two types of CTEs: Non-recursive CTE and Recursive CTE.

* Non-recursive CTE
* Recursive CTE 

Non-recursive CTE:
A non-recursive CTE is a CTE that references itself only once in its definition and does not use the UNION operator. In other words, a non-recursive CTE is a simple SELECT statement that is defined once and then used in another query.

```
WITH CTE_NAME AS(

SELECT column_name

FROM table_name
)
SELECT column_name

FROM CTE_NAME;
```
A recursive SQL common table expression (CTE) is a query that continuously references a previous result until it returns an empty result.

```
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
```
