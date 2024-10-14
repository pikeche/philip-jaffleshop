{% macro dev_data_limit(column_name, dev_data_limit_days=10) %}
{% if target.name != "sand"%}
where {{ column_name }} >= dateadd('day', - {{ dev_data_limit_days }}, current_timestamp)
-- where {{ column_name }} > date_trunc('month', current_date)
{% endif %}
{% endmacro %}