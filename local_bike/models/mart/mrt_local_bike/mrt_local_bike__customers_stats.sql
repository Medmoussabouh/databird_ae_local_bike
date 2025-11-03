select 
    count(distinct order_customer_id) as customer_count 
from {{ ref('int_local_bike__sales') }}