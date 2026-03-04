-- Teste customizado: garante que não existem pedidos com valor negativo ou zero
-- Se retornar linhas, o teste falha

SELECT
    order_id,
    total_amount
FROM {{ ref('stg_orders') }}
WHERE total_amount <= 0