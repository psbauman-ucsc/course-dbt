{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
  e.event_id,
  e.user_id,
  e.session_id,
  e.order_id,
  e.product_id,
  e.event_type,
  e.created_date,
  e.created_hour,
  e.page_url,  
  u.country,
  u.state,
  u.zip_code
    
from {{ ref('stg_postgres__events') }} as e

left join {{ ref('stg_postgres__users') }} as u
  on e.user_id = u.user_id
