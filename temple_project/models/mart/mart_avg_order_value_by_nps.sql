{{ config(
    materialized = 'table'
) }}

SELECT
    nps,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_total_value), 2) AS avg_order_value,
    ROUND(AVG(sku_count), 2) AS avg_sku_count
FROM {{ ref('core_orders') }}
GROUP BY ALL
