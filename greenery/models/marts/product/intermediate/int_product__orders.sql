{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
    o.order_id,
    i.product_id,
    i.quantity as order_quantity,
    o.user_id,
    o.created_at as order_date,
    o.order_total,
    o.status
    
from {{ ref('stg_postgres__orders') }} as o
left join {{ ref('stg_postgres__order_items') }} as i
on i.order_id = o.order_id
