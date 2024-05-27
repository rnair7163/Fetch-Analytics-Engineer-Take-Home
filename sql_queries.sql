-- For SQL query exercise, I am using PostgreSQL.

/*
 Question 1 - What are the top 5 brands by receipts scanned for most recent month?
*/

with base as (
    select ril.brandCode,
           to_char(r.dateScanned, 'YYYY-MM') as year_month,
           count(r.id) as receipts_scanned_count,
           dense_rank() over(order by to_char(r.dateScanned, 'YYYY-MM') desc, count(r.id) desc) as rnk
    from receipts_items_list as ril 
    join receipts_updated as r 
      on ril.receipt_id = r.id
    where to_char(r.dateScanned, 'YYYY-MM') = (select max(to_char(r.dateScanned, 'YYYY-MM')) from receipts)
      and ril.brandCode is not null
    group by ril.brandCode,
             to_char(r.dateScanned, 'YYYY-MM') as year_month
)

select brandCode
from base 
where rnk <= 5
---------------------------------------------------------------------------------------------------------------

/*
 Question 2 - How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
*/

----------------------------------------------------------------------------------------------------------------

/*
 Question 3 - When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
*/

-- During the data exploration, I noticed there is no record available for rewardsReceiptStatus = 'Acepted'. This is a data quality issue or 
-- which might need to be addressed but for now, I am going with the assumption that Accepted in this case means Finished.

with base as (
    select rewardsReceiptStatus,
           totalSpent
    from receipts_updated 
    where rewardsReceiptStatus in ('Finished', 'Rejected')
)

select avg(case when rewardsReceiptStatus = 'Finished' then totalSpent end) as average_accepted_spend,
       avg(case when rewardsReceiptStatus = 'Rejected' then totalSpent end) as average_rejected_spend
from base 
----------------------------------------------------------------------------------------------------------------

/*
 Question 4 - When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
*/

-- Just like question 3, I am going with the assumption that Accepted in this case means Finished.

with base as (
    select rewardsReceiptStatus,
           purchasedItemCount
    from receipts_updated 
    where rewardsReceiptStatus in ('Finished', 'Rejected')
)

select sum(case when rewardsReceiptStatus = 'Finished' then purchasedItemCount end) as average_accepted_spend,
       sum(case when rewardsReceiptStatus = 'Rejected' then purchasedItemCount end) as average_rejected_spend
from base 
----------------------------------------------------------------------------------------------------------------

/*
 Question 5 - Which brand has the most spend among users who were created within the past 6 months?
*/

with user_info as (
    select r.userId,
           r.id
    from receipts_updated as r 
    join users_updated as u on r.userId = u.id 
    where extract(month from now() - u.createdDate) <= 6
)

select ril.brandCode,
       sum(itemPrice * quantityPurchased) as total_spend
from receipts_items_list ril
join user_info on ril.receipt_id = user_info.id 
group by ril.brandCode
order by sum(itemPrice * quantityPurchased) desc
----------------------------------------------------------------------------------------------------------------

/*
 Question 6 - Which brand has the most transactions among users who were created within the past 6 months?
*/

with user_info as (
    select r.userId,
           r.id
    from receipts_updated as r 
    join users_updated as u on r.userId = u.id 
    where extract(month from now() - u.createdDate) <= 6
)

select ril.brandCode,
       sum(quantityPurchased) as total_transactions
from receipts_items_list ril
join user_info on ril.receipt_id = user_info.id 
group by ril.brandCode
order by sum(quantityPurchased) desc