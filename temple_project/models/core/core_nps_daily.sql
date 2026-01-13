{{ config(
    materialized = 'table'
) }}

WITH nps_base AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        DATE_TRUNC('year', order_date) AS year,
        order_date,
        nps,
        customer_type,
        state
    FROM {{ ref('stg_order_nps') }}
)

SELECT
    year,
    month,
    order_date,
    customer_type,
    state,
    COUNT(CASE WHEN nps = 'Promoter' THEN 1 END) AS promoters,
    COUNT(CASE WHEN nps = 'Detractor' THEN 1 END) AS detractors,
    COUNT(*) AS total_orders,
    ROUND(
        100.0
        * (COUNT(CASE WHEN nps = 'Promoter' THEN 1 END)
        - COUNT(CASE WHEN nps = 'Detractor' THEN 1 END))
        / COUNT(*),
        2
    ) AS nps
FROM nps_base
GROUP BY ALL
