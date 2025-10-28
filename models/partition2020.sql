{{ config(
    materialized = 'table',
    schema = 'SILVER',
    database = 'DATALAKE'
) }}
select * from {{ref('joins')}}
where date_part(year, order_date) = 2020