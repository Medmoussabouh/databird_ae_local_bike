WITH revenue_per_state_store AS (
SELECT
  store_state, 
  store_name,
  COUNT(distinct(order_id)) AS order_count,
  ROUND(sum(coalesce(revenue, 0)), 2) as total_revenue
FROM {{ ref('int_local_bike__sales') }}
GROUP BY
  store_state, store_name
)

SELECT 
    revenue_per_state_store.*,
    rank() over (partition by store_state order by total_revenue desc) as store_rank_revenue_per_state
FROM revenue_per_state_store
QUALIFY store_rank_revenue_per_state <= 5
order by store_state, store_rank_revenue_per_state
