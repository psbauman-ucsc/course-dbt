{{
  config(
    enabled=true,
    materialized='view'
  )
}}


select distinct

  e.session_id,
  oi.product_id,
  p.name as product_name

from {{ ref('stg_postgres__events') }} as e

left join {{ ref('stg_postgres__order_items') }} as oi
 on oi.order_id = e.order_id

left join {{ ref('stg_postgres__products') }} as p
on p.product_id = oi.product_id

where e.event_type = 'checkout'
