with sources as(

select * from {{ source('northwind_meq6', 'customers') }}

)

select * from sources
