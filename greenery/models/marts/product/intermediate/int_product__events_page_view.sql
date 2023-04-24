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
product_id

from {{ ref('int_postgres__events') }}
where event_type = 'page_view'