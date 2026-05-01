-- 1. removing empty columns from sales202512

ALTER TABLE sales.sales202512 DROP COLUMN string_field_5;

ALTER TABLE sales.sales202512 DROP COLUMN string_field_6;

ALTER TABLE sales.sales202512 DROP COLUMN string_field_7;


-- 2. appending sales tables together

CREATE OR REPLACE TABLE `project-698d2855-dfa3-4bd4-974.sales.sales_2025` AS
SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202501`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202502`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202503`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202504`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202505`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202506`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202507`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202508`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202509`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202510`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202511`
UNION ALL SELECT * FROM `project-698d2855-dfa3-4bd4-974.sales.sales202512`;

--alternative: 
--CREATE OR REPLACE TABLE `project-698d2855-dfa3-4bd4-974.sales.sales_2025` AS
--SELECT *
--FROM `project-698d2855-dfa3-4bd4-974.sales.sales2025*`