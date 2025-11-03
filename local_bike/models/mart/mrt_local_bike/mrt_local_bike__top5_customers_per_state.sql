WITH revenue_per_state_customer AS (
SELECT
  store_state, 
  order_customer_id,
  customer_full_name,
  COUNT(distinct(order_id)) AS order_count,
  ROUND(sum(coalesce(revenue, 0)), 2) as total_revenue
FROM {{ ref('int_local_bike__sales') }}
GROUP BY
  store_state, order_customer_id, customer_full_name
)

SELECT 
    revenue_per_state_customer.*,
    rank() over (partition by store_state order by total_revenue desc) as customer_rank_revenue_per_state
FROM revenue_per_state_customer
QUALIFY customer_rank_revenue_per_state <= 5
order by store_state, customer_rank_revenue_per_state
