{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select distinct

  e.user_id,
  e.session_id,
  e.order_id,
  e.product_id,
  v.created_date as page_view_date,
  v.created_hour as page_view_hour,
  v.page_url as page_view_url,
  c.created_date as checkout_date,
  c.created_hour as checkout_hour,
  c.page_url as checkout_url,
  c.order_total as checkout_order_total,
  s.created_date as shipping_date,
  s.created_hour as shipping_hour,
  s.page_url as shipping_url,  
  s.country as shipping_country,
  s.state as shipping_state,
  s.zip_code as shipping_zip_code,
  s.tracking_id,
  s.shipping_service,
  s.estimated_delivery_at,
  s.delivered_at

from {{ ref('int_product__events') }} as e

left join {{ ref('int_product__events_page_view') }} as v
 on v.user_id = e.user_id
 and v.session_id = e.session_id

left outer join {{ ref('int_product__events_checkout') }} as c
 on c.user_id = e.user_id
and c.session_id = e.session_id

left outer join {{ ref('int_product__events_shipped') }} as s
 on s.user_id = e.user_id
and s.session_id = e.session_id
