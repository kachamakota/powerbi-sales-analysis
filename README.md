# RFM Customer Segmentation (BigQuery + Power BI)

The data was processed in BigQuery using SQL, and the final table was used in Power BI for visualization.

## Goal

The goal of this project was to segment customers based on their purchasing behavior using RFM analysis (Recency, Frequency, Monetary).

---

## Dataset

The dataset contains sales data, where each row represents a single order. Original data format files is csv.

Main fields used:
- CustomerID  
- OrderDate  
- OrderValue  

---

## Status

Completed.

---

## Notes

- RFM metrics were calculated per customer:
  - Recency – days since last purchase  
  - Frequency – number of orders  
  - Monetary – total spend  

- Each metric was scored using deciles (1–10)

- A total RFM score was calculated by summing individual scores (3-30)

- Customers were assigned to segments based on the total score:
  - VIPs  
  - Loyal Customers  
  - Potential Loyalists  
  - Promising  
  - Engaged  
  - Requires Attention  
  - At Risk  
  - Lost or Inactive  
