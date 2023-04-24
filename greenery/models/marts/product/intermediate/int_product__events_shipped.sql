{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select

  event_id,
  user_id,
  session_id,
  order_id,
  product_id,
  event_type,
  created_date
  created_hour
  page_url,  
  country,
  state,
  zip_code,
  tracking_id,
  shipping_service,
  estimated_delivery_at,
  delivered_at

from {{ ref('int_postgres__events') }}
where event_type in ('package_shipped')