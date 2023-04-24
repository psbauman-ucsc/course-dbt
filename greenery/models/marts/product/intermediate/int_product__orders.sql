{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
    order_id,
    user_id,
    created_at as order_date,
    order_total,
    status
    
from {{ ref('stg_postgres__orders') }}
