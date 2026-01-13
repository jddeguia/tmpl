{{ config(
    materialized = 'table'
) }}

WITH exploded_products AS (
    SELECT
        order_id,
        order_date,
        EXTRACT(year FROM order_date) AS year,
        EXTRACT(month FROM order_date) AS month,
        customer_type,
        state,
        nps,
        nps_score,
        STRING_SPLIT(product_categories, ', ') AS product_category
    FROM {{ ref('core_orders') }}
)

SELECT *
FROM exploded_products
