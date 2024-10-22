WITH paid_orders AS (
    SELECT
        orders.id AS order_id,
        orders.user_id AS customer_id,
        orders.order_date AS order_placed_at,
        orders.status AS order_status,
        p.total_amount_paid,
        p.payment_finalized_date,
        c.first_name AS customer_first_name,
        c.last_name AS customer_last_name
    FROM {{ source('jaffle_shop', 'orders') }}
    LEFT JOIN {{ ref('int__failed_payment') }} AS p
        ON orders.id = p.order_id
    LEFT JOIN {{ source('jaffle_shop', 'customers') }} AS c
        ON orders.user_id = c.id
)

SELECT * FROM paid_orders
