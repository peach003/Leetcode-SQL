SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person AS p
LEFT JOIN Address AS a
ON p.personId = a.personId;

-- =========================================================
-- SQL Logical Execution Order (ASCII Flow)
--
-- 1. FROM           ← Load data source (tables, subqueries)
--    Person AS p    ← Assign alias 'p' to table Person
-- 2. JOIN           ← Combine with other tables (e.g., LEFT JOIN Address AS a)
-- 3. WHERE          ← Filter rows by condition (can use p.column, a.column)
-- 4. GROUP BY       ← Group rows
-- 5. HAVING         ← Filter groups
-- 6. SELECT         ← Choose columns to return (can use aliases from FROM)
-- 7. ORDER BY       ← Sort results
-- 8. LIMIT/OFFSET   ← Restrict number of rows
--
-- Execution Flow:
-- ┌──────────────┐
-- │  FROM        │  ← ① Identify source table(s), assign aliases
-- │ Person AS p  │
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  JOIN        │  ← ② Combine with other tables (LEFT/RIGHT/INNER JOIN)
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  WHERE       │  ← ③ Filter rows
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  GROUP BY    │  ← ④ Group rows
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  HAVING      │  ← ⑤ Filter groups
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  SELECT      │  ← ⑥ Output selected columns
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  ORDER BY    │  ← ⑦ Sort
-- └──────┬───────┘
--        │
-- ┌──────▼───────┐
-- │  LIMIT       │  ← ⑧ Limit rows
-- └──────────────┘
--
-- Notes:
-- - Table aliases (AS p) are assigned in FROM/JOIN stage
-- - Aliases can be used in SELECT, WHERE, JOIN conditions
-- - Aliases are only valid within the current query
-- =========================================================
