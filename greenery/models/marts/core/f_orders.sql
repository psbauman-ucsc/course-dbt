{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select

  o.user_id,
  o.session_id,
  o.order_id,
  c.created_date as checkout_date,
  c.created_hour as checkout_hour,
  c.page_url as checkout_url,
  s.created_date as shipping_date,
  s.created_hour as shipping_hour,
  s.page_url as shipping_url,
  o.order_date,
  o.order_total,
  o.tracking_id,
  o.shipping_service,
  o.estimated_delivery_at,
  o.delivered_at

from {{ ref('int_core__orders') }} as o

left outer join {{ ref('int_core__events_checkout') }} as c
 on c.user_id = o.user_id
and c.session_id = o.session_id

left outer join {{ ref('int_core__events_shipped') }} as s
 on s.user_id = o.user_id
and s.session_id = o.session_id
