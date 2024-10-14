##### Week 1 Assignment Q/A

How many users do we have?   
**130**  
``` sql
SELECT 
    count(distinct user_id) 
FROM 
    DEV_DB.DBT_SDWINDGMAILCOM.STG_POSTGRES__ORDERS
``` 
On average, how many orders do we receive per hour?    
**7 (actual 7.680851 rounded down)**  
``` sql
WITH order_data AS (
    SELECT 
        COUNT(distinct order_id) AS total_orders,
        DATEDIFF('hour', MIN(created_at), MAX(created_at)) AS total_hours
    FROM 
        DEV_DB.DBT_SDWINDGMAILCOM.STG_POSTGRES__ORDERS
)
SELECT 
   total_orders / NULLIF(total_hours, 0) AS avg_orders_per_hour
FROM 
order_data;
```

On average, how long does an order take from being placed to being delivered?   
**About 4 days**  
``` sql
WITH delivery_times AS (
    SELECT 
        DATEDIFF('minute', created_at, delivered_at) AS delivery_time_minutes
    FROM 
        DEV_DB.DBT_SDWINDGMAILCOM.STG_POSTGRES__ORDERS
    WHERE 
        delivered_at IS NOT NULL
)
SELECT 
    AVG(delivery_time_minutes) / 1440 AS avg_delivery_time_days,  -- 1440 minutes in a day
    MOD(AVG(delivery_time_minutes), 1440) / 60 AS avg_delivery_time_hours -- remainder of minutes converted to hours
FROM 
    delivery_times;
```

How many users have only made one purchase? Two purchases? Three+ purchases? (Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.)  
**1 purchase: 25 users**  
**2 purchases: 28 users**  
**3+ purchase: 71 users**   
``` sql
WITH user_order_counts AS (
    SELECT 
        user_id,
        COUNT(order_id) AS total_purchases
    FROM 
        orders
    GROUP BY 
        user_id
)
SELECT 
    CASE 
        WHEN total_purchases = 1 THEN '1 purchase'
        WHEN total_purchases = 2 THEN '2 purchases'
        ELSE '3+ purchases'
    END AS purchase_category,
    COUNT(user_id) AS user_count
FROM 
    user_order_counts
GROUP BY 
    purchase_category
ORDER BY 
    purchase_category;

```  
On average, how many unique sessions do we have per hour?  
**10 sessions per hour**  
``` sql
WITH session_data AS (
    SELECT 
        COUNT(DISTINCT session_id) AS unique_sessions,
        DATEDIFF('hour', MIN(created_at), MAX(created_at)) AS total_hours
    FROM 
        DEV_DB.DBT_SDWINDGMAILCOM.STG_POSTGRES__events
)
SELECT 
    unique_sessions / NULLIF(total_hours, 0) AS avg_sessions_per_hour
FROM 
    session_data;
```