-- {{ config(enabled = false) }}

{% test assert_column_greater_than_three( model, column_name) %}

select
    {{ column_name }}
from {{ model }}
where {{ column_name }} <= 3

{% endtest %}