with product_sessions as (
    SELECT distinct product_id, count(distinct session_id) as sessions, date(session_ended_at) as date_day, sum(checkouts) as checkouts
    from  {{ ref('fact_sessions') }}
    group by 1,3
),
products as (
    SELECT product_id, name from {{ ref('stg_postgres__products') }}
),
dim_date as (
    select date_day,week_start_date from {{ ref('dim_date') }}
) 
select 
    products.product_id, 
    products.name,
    dim_date.week_start_date,
    sum(product_sessions.sessions) as total_sessions,
    sum(product_sessions.checkouts) as converted_sessions
from product_sessions
inner join products on products.product_id = product_sessions.product_id
inner join dim_date on dim_date.date_day = product_sessions.date_day
group by 1,2,3