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
  created_date as view_date,
  created_hour as view_hour,
  page_url as view_url

from {{ ref('stg_postgres__events') }}
where event_type = 'page_view'