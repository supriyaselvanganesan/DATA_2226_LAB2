with source as (
    select
        symbol,
        date,
        open,
        high,
        low,
        close,
        volume
    from USER_DB_KOALA.RAW.stock_price_amazon_meta
),

cleaned_data as (
    select
        upper(trim(symbol)) as symbol,    
        try_to_date(date) as date,    
        try_to_number(open, 12, 4) as open,
        try_to_number(high, 12, 4) as high,
        try_to_number(low, 12, 4) as low,
        try_to_number(close, 12, 4) as close,
        try_to_number(volume, 38, 0) as volume
    from source
    where symbol is not null
      and date is not null
      and close is not null
      and volume >= 0
)

select
    symbol,
    date,
    open,
    high,
    low,
    close,
    volume
from cleaned_data