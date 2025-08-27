SELECT 
    IFNULL(
        (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            LIMIT 1 OFFSET 1
        ),
    NULL) AS SecondHighestSalary;

SELECT 
    MAX(salary) AS SecondHighestSalary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = 2;
-- =========================================================
-- SQL Null Handling Functions & DENSE_RANK() Notes
-- =========================================================
--
-- 1. Null Handling Functions (空值处理函数)
-- ---------------------------------------------------------
-- IFNULL(expr1, expr2)   [MySQL / SQLite]
--   - If expr1 is NULL, return expr2; else return expr1.
--   - Example:
--       SELECT IFNULL(salary, 0) FROM Employee;
--       -- If salary is NULL, show 0
--
-- COALESCE(expr1, expr2, expr3, ...)
--   - Returns the first non-NULL value in the list.
--   - More general than IFNULL, works in most databases.
--   - Example:
--       SELECT COALESCE(salary, bonus, 0) FROM Employee;
--       -- Returns salary if not NULL, else bonus, else 0
--
-- NULLIF(expr1, expr2)
--   - Returns NULL if expr1 = expr2; otherwise returns expr1.
--   - Example:
--       SELECT NULLIF(salary, 0) FROM Employee;
--       -- If salary = 0, return NULL
--
-- ---------------------------------------------------------
--
-- 2. DENSE_RANK() Window Function (密集排名函数)
-- ---------------------------------------------------------
-- Syntax:
--   DENSE_RANK() OVER (
--       [PARTITION BY col1, col2, ...] -- optional, group data before ranking
--       ORDER BY col3 [ASC|DESC]       -- define ranking order
--   )
--
-- Function:
--   - Assigns ranks to rows within a result set without gaps in rank values.
--   - Rows with equal values get the same rank; next rank is incremented by 1.
--
-- Example:
--   SELECT salary,
--          DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
--   FROM Employee;
--
--   salary | rnk
--   -------|----
--     300  | 1
--     200  | 2
--     200  | 2
--     100  | 3
--
-- Difference from RANK():
--   salary | RANK | DENSE_RANK
--   -------|------|-----------
--     300  | 1    | 1
--     200  | 2    | 2
--     200  | 2    | 2
--     100  | 4    | 3   <-- RANK skips to 4, DENSE_RANK goes to 3
--
-- ---------------------------------------------------------
--
-- 3. Second Highest Salary Example (Using DENSE_RANK)
-- ---------------------------------------------------------
-- SELECT MAX(salary) AS SecondHighestSalary
-- FROM (
--     SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
--     FROM Employee
-- ) t
-- WHERE rnk = 2;
--
-- Logic:
--   1. Rank salaries in descending order (ties get same rank)
--   2. Filter where rank = 2 (second highest salary)
--   3. Use MAX() to ensure single row output
-- =========================================================
