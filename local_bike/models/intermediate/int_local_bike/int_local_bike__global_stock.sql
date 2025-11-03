select 
    product_id as product_id,
    sum(coalesce(available_quantity, 0)) as available_quantity,
from {{ ref('stg_local_bike__stocks') }}
group by product_id



