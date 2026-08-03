{{ config(
    materialized='view'
    ) }}

with orders_cte as (
    select *
    from {{ref('stg_orders')}}
),

customers_cte as (
    select *
    from {{ref('stg_customer')}}
)

select 
    o.order_id,
    o.required_date,
    o.shipped_date,
    {{ dbt.datediff('o.required_date', 'o.shipped_date', 'day') }} AS days_late,
    c.company_name,
    c.city,
    c.country
from orders_cte o
    left join customers_cte c on o.customer_id = c.customer_id