{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select 
    address_id,
    address,
    zip_code,
    state,
    country
from {{ ref('base_postgres__addresses') }}
