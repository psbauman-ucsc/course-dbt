{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
  o.user_id,
  o.session_id,
  o.order_id,
  o.created_at as order_date
  o.order_total,
  o.tracking_id,
  o.shipping_service,
  o.estimated_delivery_at,
  o.delivered_at
    
from {{ ref('stg_postgres__orders') }}
