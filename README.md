# COMMON-TABLE-EXPRESSION
a named temporary result set that exists within the scope of a single statement and that can be referred to later within that statement, possibly multiple times.

A Common Table Expression (CTE) is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. CTEs are defined within the execution scope of a single SELECT, INSERT, UPDATE, or DELETE statement.

There are two types of CTEs: Non-recursive CTE and Recursive CTE.

* Non-recursive CTE
* Recursive CTE 

Non-recursive CTE:
A non-recursive CTE is a CTE that references itself only once in its definition and does not use the UNION operator. In other words, a non-recursive CTE is a simple SELECT statement that is defined once and then used in another query.

