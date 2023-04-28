{{
  config(
    enabled=true,
    materialized='table'
  )
}}

with view_events as (
  select product_id, 
  count(distinct session_id) as view_sessions 
  from {{ ref('int_product__views') }}
  group by product_id
),

purchase_events as (
  select product_id,
  product_name,
  count(session_id) as checkout_sessions 
  from {{ ref('int_product__checkouts' ) }}
  group by product_id, product_name
)

select p.product_id,
p.product_name,
round((p.checkout_sessions / v.view_sessions)*100,2) as conversion_rate
from purchase_events as p, view_events as v
where p.product_id = v.product_id
