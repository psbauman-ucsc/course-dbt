{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select

  e.event_id,
  e.user_id,
  e.session_id,
  e.order_id,
  e.product_id,
  e.event_type,
  e.created_date,
  e.created_hour,
  e.page_url,
  o.order_total
 
from {{ ref('int_postgres__events') }} as e
left join {{ ref('stg_postgres__orders') }} as o
  on e.order_id = o.order_id
where event_type = 'checkout'