{{ config(
    materialized = 'table'
) }}

WITH exploded_products AS (
    SELECT
        order_id,
        order_date,
        state,
        customer_type,
        nps,
        STRING_SPLIT(product_categories, ', ') AS product_category
    FROM {{ ref('core_orders') }}
)

SELECT
    product_category,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN nps = 'Detractor' THEN 1 END) AS detractors,
    ROUND(100.0 * COUNT(CASE WHEN nps = 'Detractor' THEN 1 END) / COUNT(*), 2) AS pct_detractors,
    ROUND(AVG(EXTRACT(YEAR FROM order_date)), 0) AS avg_year -- optional
FROM exploded_products
GROUP BY ALL