{{ config(
    materialized = 'table'
) }}

SELECT
    order_id,
    state,
    customer_type,
    order_sku_count,
    CAST(order_date AS DATE) AS order_date,
    CAST(nps_sent_date AS DATE) AS nps_sent_date,
    CAST(nps_scored_date AS DATE) AS nps_scored_date,
    nps_score,
    nps,
    order_total_value
FROM  {{ref('order_nps')}}
WHERE order_id IS NOT NULL