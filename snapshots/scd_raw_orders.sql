{% snapshot scd_raw_orders %}

-- {% set new_schema = target.schema + '_snapshot' %}
{% set schema = target.schema %}

{{
    config(
      target_database='sandbox',
      target_schema=schema,
      unique_key='id',
      strategy='timestamp',
      updated_at='_ETL_LOADED_AT',
    )
}}

select * from {{ source('jaffle_shop','orders') }}

{% endsnapshot %}