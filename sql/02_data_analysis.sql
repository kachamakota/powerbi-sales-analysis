

-- 1. calculation of RECENCY, FREQUENCY and MONETARY
-- 1.1 combining views with CTEs

CREATE OR REPLACE VIEW `project-698d2855-dfa3-4bd4-974.sales.rfm_metrics`
AS
WITH current_date AS (
  SELECT DATE('2026-03-06') AS analysis_date -- fixed analysis date for reproducibility
),
rfm AS (
  SELECT
    CustomerID,
    MAX(OrderDate) AS last_order_date,
    date_diff((SELECT analysis_date FROM current_date), MAX(OrderDate), DAY) AS recency,
    COUNT(*) AS frequency, -- orderid is unique, no need to use count distinct
    SUM(OrderValue) AS monetary
  FROM `project-698d2855-dfa3-4bd4-974.sales.sales_2025`
  GROUP BY CustomerID
)
SELECT 
  rfm.*,
  ROW_NUMBER() OVER(ORDER BY recency ASC) AS r_rank,
  ROW_NUMBER() OVER(ORDER BY frequency DESC) AS f_rank,
  ROW_NUMBER() OVER(ORDER BY monetary DESC) AS m_rank
FROM rfm;

-- 1.2 Assigning deciles (10 BEST, 1 WORST score)

CREATE OR REPLACE VIEW `project-698d2855-dfa3-4bd4-974.sales.rfm_scores`
AS
SELECT
  *,
  NTILE(10) OVER(ORDER BY r_rank DESC) AS r_score,
  NTILE(10) OVER(ORDER BY f_rank DESC) AS f_score,
  NTILE(10) OVER(ORDER BY m_rank DESC) AS m_score
FROM `project-698d2855-dfa3-4bd4-974.sales.rfm_metrics`;


-- 1.3 Calculating total score

CREATE OR REPLACE VIEW `project-698d2855-dfa3-4bd4-974.sales.rfm_total_scores`
AS
SELECT
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS rfm_total_score
FROM `project-698d2855-dfa3-4bd4-974.sales.rfm_scores`
ORDER BY rfm_total_score DESC;


-- 2. Creating a table to use in PowerBI
CREATE OR REPLACE TABLE `project-698d2855-dfa3-4bd4-974.sales.rfm_segments_final`
AS
SELECT
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  rfm_total_score,
  CASE
    WHEN rfm_total_score >= 28 THEN 'VIPs'
    WHEN rfm_total_score >= 24 THEN 'Loyal Customers'
    WHEN rfm_total_score >= 20 THEN 'Potential Loyalists'
    WHEN rfm_total_score >= 16 THEN 'Promising'
    WHEN rfm_total_score >= 12 THEN 'Engaged'
    WHEN rfm_total_score >= 8 THEN 'Requires Attention'
    WHEN rfm_total_score >= 4 THEN 'At Risk'
    ELSE 'Lost or Inactive'
  END AS rfm_segment
FROM `project-698d2855-dfa3-4bd4-974.sales.rfm_total_scores`
ORDER BY rfm_total_score DESC;








