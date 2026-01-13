{{ config(
    materialized = 'table'
) }}

SELECT *
FROM {{ ref('core_nps_daily') }}
