with cleanData as (
  select *
  from {{ ref('stg_stock_price') }}
),

tech_features as (
  select
    symbol,
    date,
    close,
    volume,

    -- Calculating Simple Moving Averages
    avg(close) over (
      partition by symbol order by date
      rows between 19 preceding and current row
    ) as sma_20,

    avg(close) over (
      partition by symbol order by date
      rows between 49 preceding and current row
    ) as sma_50,

    avg(close) over (
      partition by symbol order by date
      rows between 199 preceding and current row
    ) as sma_200,

    -- Calculating 10 day momentum
    (close - lag(close, 10) over (
      partition by symbol order by date
    )) as momentum_10
  from cleanData
),

day_diffs as (
  select
    symbol,
    date,
    close,
    volume,
    sma_20, sma_50, sma_200, momentum_10,
    close - lag(close) over (
      partition by symbol order by date
    ) as chg
  from tech_features
),

gain_loss as (
  select
    symbol,
    date,
    close,
    volume,
    sma_20, sma_50, sma_200, momentum_10,
    iff(chg > 0, chg, 0)        as gain,
    iff(chg < 0, -chg, 0)       as loss
  from day_diffs
),

rolling_avg as (
  -- Calculating Rolling averages 14 days
  select
    symbol,
    date,
    close,
    volume,
    sma_20, sma_50, sma_200, momentum_10,
    avg(gain) over (
      partition by symbol order by date
      rows between 13 preceding and current row
    ) as avg_gain,
    avg(loss) over (
      partition by symbol order by date
      rows between 13 preceding and current row
    ) as avg_loss
  from gain_loss
),

final_output as (
  select
    symbol,
    date,
    close,
    volume,
    sma_20,
    sma_50,
    sma_200,
    momentum_10,
    case
      when avg_gain is null and avg_loss is null then null
      when coalesce(avg_loss, 0) = 0 and coalesce(avg_gain, 0) > 0 then 100
      when coalesce(avg_gain, 0) = 0 and coalesce(avg_loss, 0) > 0 then 0
      when coalesce(avg_loss, 0) = 0 then null
      else 100 - 100 / (1 + (avg_gain / avg_loss))
    end as rsi_14
  from rolling_avg
)


select
  symbol,
  date,
  close,
  volume,
  sma_20,
  sma_50,
  sma_200,
  momentum_10,
  rsi_14
from final_output
















