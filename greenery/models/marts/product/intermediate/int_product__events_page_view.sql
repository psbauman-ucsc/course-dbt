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
  created_date,
  created_hour,
  page_url

from {{ ref('int_postgres__events') }}
where event_type = 'page_view'