
{{
  config(
    enabled=true,
    materialized='table'
  )
}}

select distinct

  v.user_id,
  v.session_id,
  vo.order_id,
  v.product_id,
  v.page_view_date,
  v.page_view_hour,
  v.page_url,
  o.order_total

from {{ ref('int_product__page_views') }} as v

left outer join {{ ref('int_product__events') }} as vo
 on vo.user_id = v.user_id
 and vo.session_id = v.session_id
 and vo.order_id is not null

left outer join {{ ref('int_product__orders') }} as o
 on o.order_id = vo.order_id