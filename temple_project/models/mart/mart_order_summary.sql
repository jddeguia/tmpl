{{ config(
    materialized = 'table'
) }}

SELECT *
FROM {{ ref('core_orders') }}
