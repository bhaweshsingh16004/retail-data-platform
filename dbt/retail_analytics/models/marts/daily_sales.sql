select
    order_date,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_quantity,
    sum(sales_amount) as total_sales

from {{ ref('stg_orders') }}

group by
    order_date