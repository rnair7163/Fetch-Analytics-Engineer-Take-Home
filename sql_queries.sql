/*
 Question 1 - What are the top 5 brands by receipts scanned for most recent month?
*/

-- Query
with base as (
    select ril.brandCode,
           to_char(r.dateScanned, 'YYYY-MM') as year_month,
           count(r.id) as receipts_scanned_count,
           dense_rank() over(order by to_char(r.dateScanned, 'YYYY-MM') desc, count(r.id) desc) as rnk
    from receipts_items_list as ril 
    join receipts as r 
      on ril.receipt_id = r.id
    where to_char(r.dateScanned, 'YYYY-MM') = (select max(to_char(r.dateScanned, 'YYYY-MM')) from receipts)
    group by ril.brandCode,
             to_char(r.dateScanned, 'YYYY-MM') as year_month
)

select brandCode
from base 
where rnk <= 5
