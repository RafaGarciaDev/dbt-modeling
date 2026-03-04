{{ config(materialized='table') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

order_metrics AS (
    SELECT
        customer_id,
        COUNT(order_id)                             AS total_orders,
        SUM(total_amount)                           AS lifetime_value,
        AVG(total_amount)                           AS avg_order_value,
        MIN(order_date_clean)                       AS first_order_date,
        MAX(order_date_clean)                       AS last_order_date,
        SUM(CASE WHEN status = 'completed'
                 THEN total_amount ELSE 0 END)      AS completed_revenue,
        SUM(CASE WHEN status = 'cancelled'
                 THEN 1 ELSE 0 END)                 AS cancelled_orders
    FROM orders
    GROUP BY customer_id
),

final AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date_clean,
        o.order_year,
        o.order_month,
        o.total_amount,
        o.status,
        m.total_orders,
        m.lifetime_value,
        m.avg_order_value,
        m.first_order_date,
        m.last_order_date,
        m.completed_revenue,
        m.cancelled_orders,
        CASE
            WHEN m.lifetime_value >= 5000 THEN 'VIP'
            WHEN m.lifetime_value >= 1000 THEN 'Regular'
            ELSE 'New'
        END AS customer_tier
    FROM orders o
    LEFT JOIN order_metrics m ON o.customer_id = m.customer_id
)

SELECT * FROM final