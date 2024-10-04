{% snapshot scd_raw_products %}

{% set new_schema = target.schema + '_snapshot' %}

{{
    config(
      target_database='sandbox',
      target_schema=new_schema,
      unique_key='sku',
      strategy='check',
      check_cols=['price'],
    )
}}

select * from {{ source('jaffle_shop','products') }}

{% endsnapshot %}