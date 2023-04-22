{{
  config(
    materialized='view'
  )
}}

SELECT 
    address_id,
    address,
    zipcode as zip_code,
    state,
    country
FROM {{ source('postgres', 'addresses') }}
