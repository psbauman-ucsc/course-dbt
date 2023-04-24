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
  created_date as page_view_date,
  created_hour as page_view_hour,
  page_url

from {{ ref('int_product__events') }}
where event_type = 'page_view'