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
  e.page_url,  
  u.country,
  u.state,
  u.zip_code,
  o.tracking_id,
  o.shipping_service,
  o.estimated_delivery_at,
  o.delivered_at
    
from {{ ref('stg_postgres__events') }} as e

left join {{ ref('stg_postgres__users') }} as u
  on e.user_id = u.user_id
left join {{ ref('stg_postgres__orders') }} as o
  on e.order_id = o.order_id