{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
    order_id,
    user_id,
    product_id,
    created_at as order_date,
    order_cost,
    status
    
from {{ ref('stg_postgres__orders') }}
