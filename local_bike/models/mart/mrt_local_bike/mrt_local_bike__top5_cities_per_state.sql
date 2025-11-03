WITH revenue_per_state_city AS (
SELECT
  store_state, 
  store_city,
  COUNT(distinct(order_id)) AS order_count,
  ROUND(sum(coalesce(revenue, 0)), 2) as total_revenue
from {{ ref('int_local_bike__sales') }}
GROUP BY
  store_state, store_city
)

SELECT 
    revenue_per_state_city.*,
    rank() over (partition by store_state order by total_revenue desc) as city_rank_revenue_per_state
FROM revenue_per_state_city
QUALIFY city_rank_revenue_per_state <= 5
order by store_state,city_rank_revenue_per_state
