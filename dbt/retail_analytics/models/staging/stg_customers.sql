select
    customer_id,
    name,
    country

from {{ source('retail_raw', 'customers') }}