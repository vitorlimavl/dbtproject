{{ config(
    materialized = 'table',
    schema = 'SILVER',
    database = 'DATALAKE'
) }}
WITH CALC_EMPLOYEES AS (
select 
    date_part(year, current_date) - date_part(year, BIRTH_DATE) AS AGE,
    date_part(year, current_date) - date_part(year, HIRE_DATE) AS LENGTHOFSERVICE,
    FIRST_NAME || ' ' || LAST_NAME AS NAME, * 
from {{source('sources', 'employees')}}
)
SELECT * FROM CALC_EMPLOYEES