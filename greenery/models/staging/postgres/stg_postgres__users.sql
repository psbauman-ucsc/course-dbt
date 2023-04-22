{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.address_id,
    a.address,
    a.zip_code,
    a.state,
    a.country
  
from {{ ref('base_postgres__users') }} as u
left join {{ ref('base_postgres__addresses') }} as a
  on u.address_id = a.address_id