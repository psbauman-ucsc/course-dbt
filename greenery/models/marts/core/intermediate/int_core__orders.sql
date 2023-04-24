{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
  user_id,
  order_id,
  created_at as order_date,
  order_total,
  tracking_id,
  shipping_service,
  estimated_delivery_at,
  delivered_at
    
from {{ ref('stg_postgres__orders') }}
