{{ config(
    materialized = 'table'
) }}

WITH source AS (
    SELECT
        order_id,
        order_product_id,
        sku,
        product_category,
        supplier,
        ship_carrier
    FROM {{ ref('order_product') }}
),

summary AS (
    SELECT
        CAST(order_id AS BIGINT)           AS order_id,
        CAST(order_product_id AS BIGINT)   AS order_product_id,
        TRIM(sku)                          AS sku,
        TRIM(product_category)             AS product_category,
        TRIM(supplier)                     AS supplier,
        TRIM(ship_carrier)                 AS ship_carrier
    FROM source
    WHERE order_product_id IS NOT NULL
)

SELECT * FROM summary

