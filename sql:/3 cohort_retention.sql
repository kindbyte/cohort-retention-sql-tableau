with cohort_data as (
select customerid, invoicedate, date_trunc('month', 
min(invoicedate) over (partition by customerid)) as cohort_month
from retail_cleaned
),
month_number as (
select customerid, invoicedate, cohort_month,
extract (year from age (invoicedate, cohort_month)) *12 +
extract (month from age (invoicedate, cohort_month)) as month_number
from cohort_data 
),
base as (
select cohort_month, month_number, count(distinct customerid) as users
from month_number
group by cohort_month, month_number
),
initials as (
select cohort_month, users as initial_users
from base 
where month_number = 0
)
select b.cohort_month, b.month_number, b.users, i.initial_users, 
round(100 * (b.users::numeric /  i.initial_users), 1) as retention_percent 
from base b
join initials I on b.cohort_month = i.cohort_month
order by b.cohort_month, b.month_number;
