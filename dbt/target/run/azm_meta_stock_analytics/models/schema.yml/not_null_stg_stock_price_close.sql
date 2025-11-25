select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select close
from USER_DB_KOALA.analytics.stg_stock_price
where close is null



      
    ) dbt_internal_test