{% snapshot stock_price_snapshot %}
  {{
    config(
      target_schema = 'SNAPSHOT',
      strategy = 'check',
      unique_key = 'business_key',
      check_cols = ['OPEN', 'HIGH', 'LOW', 'CLOSE', 'VOLUME']
    )
  }}

  select
      {{ dbt_utils.generate_surrogate_key(['SYMBOL','DATE']) }} as business_key,
      SYMBOL,
      DATE,
      OPEN,
      HIGH,
      LOW,
      CLOSE,
      VOLUME
  from {{ ref('stg_stock_price') }}

{% endsnapshot %}
