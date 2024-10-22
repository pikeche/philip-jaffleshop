WITH customer_orders AS (
    SELECT
        c.id AS customer_id,
        min(order_date) AS first_order_date,
        max(order_date) AS most_recent_order_date,
        count(orders.id) AS number_of_orders
    FROM {{ source('jaffle_shop', 'customers') }} AS c
    LEFT JOIN {{ source('jaffle_shop', 'orders') }} AS orders
        ON c.id = orders.user_id
    GROUP BY 1
)

select * from  customer_orders