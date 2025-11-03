select 
    count(distinct order_store_id) as store_count 
from {{ ref('int_local_bike__sales') }}