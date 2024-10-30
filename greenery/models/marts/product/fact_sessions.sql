with events as (
    SELECT *
    from {{ ref('stg_postgres__events') }}
),
order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
),
session_timing_agg as (
    select * from {{ ref('int_session_timings') }}
)

{% set event_types = 
    'page_view',
    'add_to_cart',
    'checkout',
    'package_shipped'
%}

select 
    e.session_id,
    e.user_id,
    coalesce(e.product_id,oi.product_id) as product_id,
    session_started_at,
    session_ended_at,
    {% for event_type in event_types %}
    {{ sum_of('e.event_type', event_type) }} as {{ event_type }}s,
    {% endfor %}   
    datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from events e 
left join order_items oi 
    on oi.order_id = e.order_id
left join session_timing_agg s 
    on s.session_id = e.session_id
group by 1,2,3,4,5
