{% snapshot orders_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    status,
    CURRENT_TIMESTAMP AS updated_at
FROM {{ source('raw_data', 'orders') }}

{% endsnapshot %}