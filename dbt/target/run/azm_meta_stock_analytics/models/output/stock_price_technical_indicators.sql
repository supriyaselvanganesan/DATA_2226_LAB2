
  
    

        create or replace transient table USER_DB_KOALA.analytics.stock_price_technical_indicators
         as
        (select
  symbol,
  date,
  close,
  volume,
  sma_20,
  sma_50,
  sma_200,
  momentum_10,
  rsi_14,

  case 
    when sma_20 > sma_50 then 'Bullish'
    else 'Bearish'
  end as regime_20_50,

  case
    when rsi_14 > 70 then 'Overbought'
    when rsi_14 < 30 then 'Oversold'
    else 'Neutral'
  end as rsi_signal,

  case
    when momentum_10 > 0 then 'Uptrend'
    when momentum_10 < 0 then 'Downtrend'
    else 'No Change'
  end as momentum_signal,

  case
    when rsi_14 < 30 and momentum_10 > 0 then 'BUY'      
    when rsi_14 > 70 and momentum_10 < 0 then 'SELL'     
    else 'HOLD'
  end as trade_signal

from USER_DB_KOALA.analytics.stock_transformations
        );
      
  