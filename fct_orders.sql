{{ config(materialized='table') }}

WITH stg_orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

customers AS (
    SELECT *
    FROM {{ ref('dim_customers') }}
),

final AS (
    SELECT
        o.order_id,
        o.customer_id,
        c.customer_name,
        o.order_date,
        o.order_date_clean,
        o.order_year,
        o.order_month,
        o.total_amount,
        o.status,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date) as order_number,
        ROUND(AVG(o.total_amount) OVER (PARTITION BY o.customer_id), 2) as avg_customer_order
    FROM stg_orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id
)

SELECT *
FROM final
