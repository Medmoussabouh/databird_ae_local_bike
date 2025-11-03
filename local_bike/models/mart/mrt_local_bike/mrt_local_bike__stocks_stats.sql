select 
    count(distinct product_id) as product_stock_count
from {{ ref('int_local_bike__global_stock') }}