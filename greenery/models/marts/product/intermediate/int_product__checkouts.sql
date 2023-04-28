{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select distinct

  e.session_id,
  eo.product_id,
  p.name as product_name

from {{ ref('stg_postgres__events') }} as e

left join {{ ref('stg_postgres__products')}} as p
on p.product_id = eo.product_id

left join {{ ref('stg_postgres__events') }} as eo
 on eo.user_id = e.user_id
 and eo.session_id = e.session_id
 and eo.order_id is not null

where e.event_type = 'checkout'
