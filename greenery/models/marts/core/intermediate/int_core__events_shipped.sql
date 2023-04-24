{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select

  event_id,
  user_id,
  session_id,
  order_id,
  created_date,
  created_hour,
  page_url  

from {{ ref('stg_postgres__events') }}
where event_type = 'package_shipped')
