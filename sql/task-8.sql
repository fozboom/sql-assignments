-- Let's look at the vendor structure
select * from vendor limit 5;

-- Let's look at the purchaseorderheader structure
select * from purchaseorderheader limit 5;

-- Check the range of CreditRating
select
    "CreditRating",
    count(*) as vendor_count
from vendor
group by "CreditRating"
order by "CreditRating";

-- Main analysis of the correlation between CreditRating and transaction volume
with vendor_transactions as (
    select
        v."VendorID",
        v."Name" as vendor_name,
        v."CreditRating",
        count(poh."PurchaseOrderID") as order_count,
        coalesce(sum(poh."TotalDue"), 0) as total_amount,
        coalesce(avg(poh."TotalDue"), 0) as avg_order_amount
    from vendor v
    left join purchaseorderheader poh on v."VendorID" = poh."VendorID"
    group by v."VendorID", v."Name", v."CreditRating"
)
select
    "CreditRating",
    count(*) as vendor_count,
    round(avg(total_amount)::numeric, 2) as avg_total_amount,
    round(avg(order_count)::numeric, 2) as avg_order_count,
    round(avg(avg_order_amount)::numeric, 2) as avg_order_size,
    round(min(total_amount)::numeric, 2) as min_total,
    round(max(total_amount)::numeric, 2) as max_total,
    round(sum(total_amount)::numeric, 2) as group_total_amount
from vendor_transactions
group by "CreditRating"
order by "CreditRating";

-- Statistical correlation
with vendor_data as (
    select
        v."CreditRating"::numeric as credit_rating,
        coalesce(sum(poh."TotalDue"), 0) as total_amount
    from vendor v
    left join purchaseorderheader poh on v."VendorID" = poh."VendorID"
    group by v."VendorID", v."CreditRating"
    having coalesce(sum(poh."TotalDue"), 0) > 0
)
select
    round(corr(credit_rating, total_amount)::numeric, 4) as correlation_coefficient,
    count(*) as active_vendors,
    round(avg(credit_rating)::numeric, 2) as avg_credit_rating,
    round(avg(total_amount)::numeric, 2) as avg_transaction_amount
from vendor_data;

-- Top suppliers by rating
with vendor_stats as (
    select
        v."VendorID",
        v."Name",
        v."CreditRating",
        coalesce(sum(poh."TotalDue"), 0) as total_amount,
        count(poh."PurchaseOrderID") as order_count,
        row_number() over (partition by v."CreditRating" order by coalesce(sum(poh."TotalDue"), 0) desc) as rank_in_rating
    from vendor v
    left join purchaseorderheader poh on v."VendorID" = poh."VendorID"
    group by v."VendorID", v."Name", v."CreditRating"
)
select
    "CreditRating",
    "Name",
    round(total_amount::numeric, 2) as total_amount,
    order_count
from vendor_stats
where rank_in_rating <= 3 and total_amount > 0
order by "CreditRating", rank_in_rating;