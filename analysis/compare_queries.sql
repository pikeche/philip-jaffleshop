{% set old_relation = ref('int__paid_orders') %}
{% set dbt_relation = ref('fct_customer_orders') %}

    {{ audit_helper.compare_relations(
        a_relation = old_relation,
        b_relation = dbt_relation,
        primary_key = "order_id"
    ) }}

