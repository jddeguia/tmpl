{{ config(
    materialized = 'table'
) }}

SELECT
    order_date,
    state,
    customer_type,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN nps = 'Promoter' THEN 1 END) AS promoters,
    COUNT(CASE WHEN nps = 'Detractor' THEN 1 END) AS detractors,
    ROUND(
        100.0 * (COUNT(CASE WHEN nps = 'Promoter' THEN 1 END)
                 - COUNT(CASE WHEN nps = 'Detractor' THEN 1 END)) / COUNT(*), 2
    ) AS nps
FROM {{ ref('core_orders') }}
GROUP BY ALL
