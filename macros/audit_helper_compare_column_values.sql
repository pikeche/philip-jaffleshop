{% macro audit_helper_compare_column_values() %}
    {# Replace the table references and primary key, then run with dbt run-operation audit_helper_compare_column_values #}
    {%- set columns_to_compare = adapter.get_columns_in_relation(ref('fct_orders')) -%}

    {%- set old_etl_relation = adapter.get_relation(
        database=target.database,
        schema="pikeche",
        identifier="fct_orders"
    ) -%}
    {%- set new_etl_relation = adapter.get_relation(
        database=target.database,
        schema="pikeche",
        identifier="fct_orders"
    ) -%}

    {%- set old_etl_relation_query = "SELECT * FROM " ~ old_etl_relation -%}
    {%- set new_etl_relation_query = "SELECT * FROM " ~ new_etl_relation -%}

    {% if execute %}
        {% for column in columns_to_compare %}
            {{ log('Comparing column "' ~ column.name ~ '"', info=True) }}
            {% set audit_query = audit_helper.compare_column_values(
                a_query=old_etl_relation_query,
                b_query=new_etl_relation_query,
                primary_key="order_id",
                column_to_compare=column.name
            ) %}
            {% set audit_results = run_query(audit_query) %}

            {% do log(audit_results.column_names, info=True) %}
            {% for row in audit_results.rows %}
                {% do log(row.values(), info=True) %}
            {% endfor %}
        {% endfor %}
    {% endif %}
{% endmacro %}
