{{ config(materialized='table') }}

WITH source AS (
    SELECT DISTINCT
        customer_id
    FROM {{ ref('stg_orders') }}
),

enriched AS (
    SELECT
        o.customer_id,
        MIN(o.order_date_clean)                         AS first_order_date,
        MAX(o.order_date_clean)                         AS last_order_date,
        COUNT(o.order_id)                               AS total_orders,
        SUM(o.total_amount)                             AS lifetime_value,
        AVG(o.total_amount)                             AS avg_order_value,
        SUM(CASE WHEN o.status = 'completed'
                 THEN o.total_amount ELSE 0 END)        AS completed_revenue,
        CASE
            WHEN SUM(o.total_amount) >= 5000 THEN 'VIP'
            WHEN SUM(o.total_amount) >= 1000 THEN 'Regular'
            ELSE 'New'
        END                                             AS customer_segment,
        CURRENT_TIMESTAMP                               AS updated_at
    FROM {{ ref('stg_orders') }} o
    GROUP BY o.customer_id
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }}  AS customer_pk,
    customer_id,
    'Customer ' || customer_id                               AS customer_name,
    first_order_date,
    last_order_date,
    total_orders,
    lifetime_value,
    avg_order_value,
    completed_revenue,
    customer_segment,
    updated_at
FROM enriched