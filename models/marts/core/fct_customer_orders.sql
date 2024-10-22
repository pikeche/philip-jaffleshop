WITH
paid_orders AS (
    SELECT * FROM {{ ref('int__paid_orders') }}
),

customer_orders AS (
    SELECT * FROM {{ ref('int__customer_orders') }}
)

SELECT
    p.*,
    row_number() OVER (ORDER BY p.order_id) AS transaction_seq,
    row_number()
        OVER (PARTITION BY p.customer_id ORDER BY p.order_id)
        AS customer_sales_seq,
    CASE
        WHEN c.first_order_date = p.order_placed_at
            THEN 'new'
        ELSE 'return'
    END AS nvsr,
    x.clv_bad AS customer_lifetime_value,
    c.first_order_date AS fdos
FROM paid_orders AS p
LEFT JOIN customer_orders AS c
    ON p.customer_id = c.customer_id
LEFT OUTER JOIN
    (
        SELECT
            p.order_id,
            sum(t2.total_amount_paid) AS clv_bad
        FROM paid_orders AS p
        LEFT JOIN
            paid_orders AS t2
            ON p.customer_id = t2.customer_id AND p.order_id >= t2.order_id
        GROUP BY 1
        ORDER BY p.order_id
    ) AS x
    ON p.order_id = x.order_id
ORDER BY order_id
