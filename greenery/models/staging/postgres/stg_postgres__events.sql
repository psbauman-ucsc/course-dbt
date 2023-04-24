{{
  config(
    materialized='view'
  )
}}

SELECT 
    event_id,
    session_id,
    user_id,
    page_url,
    to_char(created_at, 'mm/dd/YYYY') AS created_date,
    to_char(created_at, 'hh') AS created_hour,
    event_type,
    order_id,
    product_id
FROM {{ source('postgres', 'events') }}
