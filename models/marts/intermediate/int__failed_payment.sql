WITH p AS (
    SELECT
        orderid AS order_id,
        max(created) AS payment_finalized_date,
        sum(amount) / 100.0 AS total_amount_paid
    FROM {{ source('stripe', 'payment') }}
    WHERE status <> 'fail'
    GROUP BY 1
)

SELECT * FROM p
