select
    product_id,
    product_name,
    category

from {{ source('retail_raw', 'products') }}