{{ config(
    materialized = 'table'
) }}

SELECT
    order_date,
    ROUND(100.0 * COUNT(CASE WHEN nps = 'Promoter' THEN 1 END) / COUNT(*), 2) AS promoter_pct,
    ROUND(100.0 * COUNT(CASE WHEN nps = 'Detractor' THEN 1 END) / COUNT(*), 2) AS detractor_pct,
    COUNT(*) AS total_orders
FROM {{ ref('core_orders') }}
GROUP BY ALL
