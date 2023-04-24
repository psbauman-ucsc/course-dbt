
{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select

  v.user_id,
  v.session_id,
  v.order_id,
  v.product_id,
  v.page_view_date,
  v.page_view_hour,
  v.page_url,
  o.order_total

from {{ ref('int_product__events_page_view') }} as v

left join {{ ref('int_product__orders') }} as o
 on v.order_id = o.order_id
