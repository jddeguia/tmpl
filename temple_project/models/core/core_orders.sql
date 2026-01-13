{{ config(
    materialized = 'table'
) }}

WITH orders_nps_base AS (
    SELECT
        order_id,
        order_date,
        nps,
        nps_score,
        customer_type,
        state,
        order_total_value
    FROM {{ ref('stg_order_nps')}}
),

order_product_base AS (
    SELECT
        order_id,
        order_product_id,
        product_category
    FROM {{ ref('stg_order_product')}}
),

summary AS (
    SELECT
        o.order_id,
        o.order_date,
        o.nps,
        o.nps_score,
        o.customer_type,
        o.state,
        o.order_total_value,
        COUNT(p.order_product_id) AS sku_count,
        STRING_AGG(p.product_category, ',') AS product_categories
    FROM orders_nps_base o
    LEFT JOIN order_product_base p ON p.order_id = o.order_id
    GROUP BY ALL
)

SELECT * FROM summary