{% if execute %}
    {% set old_relation = adapter.get_relation(
          database = target.database,
          schema = "jaffleshop_analytics",
          identifier = "fct_orders"
    ) -%}

-- {% set dbt_relation = ref('fct_orders') %}

    {% set dbt_relation = adapter.get_relation(
          database = target.database,
          schema = "jaffleshop_philip",
          identifier = "fct_orders"
    ) -%}

    {{ audit_helper.compare_relations(
        a_relation = old_relation,
        b_relation = dbt_relation,
        primary_key = "order_id"
    ) }}
{% endif %}
