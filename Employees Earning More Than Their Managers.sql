/*
自连接 (Self Join) 总结：
  - 定义：将同一张表视为两张不同表，通过别名进行连接
  - 场景：层级结构、依赖/关联关系查询
  - 关键：
      1. 必须使用别名区分两个“表”
      2. 连接条件一般是某行字段引用同表的另一行
      3. 可用 INNER / LEFT 等不同连接方式
  - 注意：无条件自连接会得到笛卡尔积
示例：查询员工及其经理
*/

SELECT e.emp_name  AS 员工,
       m.emp_name  AS 经理
FROM employees AS e
LEFT JOIN employees AS m
       ON e.manager_id = m.emp_id;
