with sources as (

    select * from {{ source('northwind_meq6', 'orders') }}

)

select * from sources