# Customer Retention Cohort Analysis

---

## Project Overview

This project performs a cohort analysis of customer retention based on online retail transaction data.  
The goal is to understand how customer activity evolves month by month after their first purchase.

---

## Data Description

The analysis uses data from the `online_retail` table containing order records:

- **InvoiceNo** — order number (string)  
- **StockCode** — product code (string)  
- **Description** — product description  
- **Quantity** — quantity ordered  
- **InvoiceDate** — date and time of order  
- **UnitPrice** — price per unit  
- **CustomerID** — customer identifier  
- **Country** — customer country  

---

## 1. Data Processing and Analysis Steps

1. **Table Creation and Data Loading**  
   The `online_retail` table was created with appropriate data types (e.g., TIMESTAMP for dates, TEXT for strings). Data was loaded from a CSV file.

2. **Data Cleaning**  
   A cleaned table `retail_cleaned` was created by removing:  
   - Records with missing `CustomerID` (anonymous customers)  
   - Returns and cancellations (`Quantity < 0`)  
   - Records with zero or negative prices (`UnitPrice <= 0`)

3. **Cohort Definition**  
   - The month of each customer's first purchase (`cohort_month`) was calculated using `DATE_TRUNC` and window functions.  
   - The number of months since the first purchase (`month_number`) was computed using `AGE()` and `EXTRACT()` functions.

4. **User Aggregation**  
   For each cohort (`cohort_month`) and month offset (`month_number`), the number of unique active customers (`users`) was counted.

5. **Retention Calculation**  
   - The size of the initial cohort (`initial_users`, where `month_number = 0`) was identified.  
   - Retention percentage was calculated as the ratio of active users in each month to the initial cohort size, rounded to one decimal place.

---

## Output

The final table `cohort_retention` includes:

- `cohort_month`: month of the customer’s first purchase  
- `month_number`: months since the first purchase (0 = first month)  
- `users`: unique active customers in that month  
- `initial_users`: size of the initial cohort  
- `retention_percent`: percentage of retained customers relative to the initial cohort

---

## 2. Tableau: Retention Heatmap

- Heatmap showing `cohort_month` (rows) vs `month_number` (columns)  
- Color encoded by `retention_percent`  
- Tooltip shows exact retention and user count  

🔗 [View interactive dashboard on Tableau Public](https://public.tableau.com/views/CustomerRetentionbyCohort_17526099566750/Sheet1)

The heatmap clearly shows how user retention declines over time for each cohort.  
Cohorts are strongest at month 0 (initial purchase), but drop steeply by month 1 and beyond.  
Notably, the average 1-month retention is just **20%**, and most cohorts drop to single-digit retention by month 3–4.

Cohorts from the later months (e.g., September–December) have incomplete data due to the dataset covering only one year.

---

## Key Insights

- Average 1-month retention: **20%**  
- Most cohorts lose >80% of users by month 3–4  
- Later cohorts (Sep–Dec) are partially observed due to data cutoff  
- Early retention is the main drop-off point — optimization opportunity

---

## Usage

This project was built using only SQL and Tableau, without Python or external libraries.  
It demonstrates how much insight can be gained through thoughtful data modeling and simple visualization.
