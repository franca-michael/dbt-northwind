with sources as (

    select * from {{ source('northwind_meq6', 'orders') }}

)

select 
    CAST(order_id AS VARCHAR) as order_id,
    CAST(customer_id AS VARCHAR) as customer_id,
    CAST(employee_id AS VARCHAR) as employee_id,
    CAST(order_date AS DATE) as order_date,
    CAST(required_date AS DATE) as required_date,
    CAST(shipped_date AS DATE) as shipped_date,
    CAST(ship_via AS VARCHAR) as ship_via,
    CAST(freight AS DECIMAL(10,2)) as freight,
    CAST(ship_name AS VARCHAR) as ship_name,
    CAST(ship_address AS VARCHAR) as ship_address,
    CAST(ship_city AS VARCHAR) as ship_city,
    CAST(ship_region AS VARCHAR) as ship_region,
    CAST(ship_postal_code AS VARCHAR) as ship_postal_code,
    CAST(ship_country AS VARCHAR) as ship_country
from sources