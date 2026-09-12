-- CI/CD branch protection test

select
    p.product_id,
    p.product_name,
    p.category,
    sum(o.quantity) as total_quantity,
    sum(o.sales_amount) as total_sales

from {{ ref('stg_orders') }} o

inner join {{ ref('stg_products') }} p
    on o.product_id = p.product_id

group by
    p.product_id,
    p.product_name,
    p.category