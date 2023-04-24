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

from {{ ref('int_postgres__events_page_views') }} as v

right outer join {{ ref('int_postgres__events_checkout') }} as c
 on c.user_id = v.user_id
and c.session_id = v.session_id
and c.order_id = v.order_id

right outer join {{ ref('int_postgres__events_shipped') }} as s
 on s.user_id = v.user_id
and s.session_id = v.session_id
and s.order_id = v.order_id
