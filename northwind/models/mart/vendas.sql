with vendas as (
    select * from {{ref("stg_crm__nova_tabela")}}
)

select * from vendas