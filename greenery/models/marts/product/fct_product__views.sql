
{{
  config(
    enabled=true,
    materialized='table'
  )
}}

select

  v.user_id,
  v.product_id,
  v.view_date,
  v.view_hour,
  v.view_url,
  o.order_id,
  o.order_date,
  o.order_quantity

from {{ ref('int_product__views') }} as v

left outer join {{ ref('int_product__orders') }} as o
 on o.user_id = v.user_id
 and o.product_id = v.product_id
