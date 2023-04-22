{{
  config(
    enabled=true,
    materialized='view'
  )
}}

select 
    address_id,
    address,
    zipcode,
    state,
    country
from {{ ref('postgres', 'base_postgres__addresses') }}
