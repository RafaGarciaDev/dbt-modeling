{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    status,
    CAST(order_date AS DATE) as order_date_clean,
    EXTRACT(YEAR FROM order_date) as order_year,
    EXTRACT(MONTH FROM order_date) as order_month
FROM {{ source('raw_data', 'orders') }}
WHERE total_amount > 0
