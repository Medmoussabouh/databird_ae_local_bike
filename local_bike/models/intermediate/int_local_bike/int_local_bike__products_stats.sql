select 
    count(product_id) as product_count
from {{ ref('stg_local_bike__products') }}