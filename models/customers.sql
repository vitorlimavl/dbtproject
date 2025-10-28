{{ config(
    materialized = 'table',
    schema = 'SILVER',
    database = 'DATALAKE'
) }}
WITH markup as (
    select * , 
    first_value(customerid)
    over(partition by companyname, contactname
    order by companyname
    rows between unbounded preceding and unbounded following) as result
    from {{source('sources', 'customers')}}
), removed as (
    select distinct result from markup
),
final as (
    select * from {{source('sources', 'customers')}} where customerid in (select result from removed)
)
select * from final