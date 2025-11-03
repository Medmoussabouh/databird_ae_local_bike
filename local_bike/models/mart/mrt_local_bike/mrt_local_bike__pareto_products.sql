with product_ordered as (
  select
    product_id,
    CONCAT(product_name, ' - (', product_category_name, ")") as product_fullname,
    revenue
    FROM {{ ref('int_local_bike__order_order_items') }}
),
cte_product_revenue as (
  select
    product_id,
    product_fullname,
    sum(revenue) as total_revenue
  from product_ordered
  group by product_id, product_fullname
  order by total_revenue desc
),
cte_product_ranked as (
  select
    *,
    sum(total_revenue) over () as grand_total_revenue,
    sum(total_revenue) over (
      order by total_revenue desc
      rows between unbounded preceding and current row
    ) as cumulative_revenue,
    rank() over (order by total_revenue desc) as revenue_rank
  from cte_product_revenue
), 
cte_product_in_stock as (
  select 
    product_id,
    available_quantity
  from {{ ref('int_local_bike__global_stock') }}
)

select
  cte_product_ranked.product_id,
  cte_product_ranked.product_fullname,
  cte_product_in_stock.available_quantity AS available_quantity,
  round(cte_product_ranked.total_revenue, 2) AS total_revenue,
  cte_product_ranked.revenue_rank,
  round(safe_divide(cte_product_ranked.cumulative_revenue, cte_product_ranked.grand_total_revenue),2) as cumulative_share,
  case
    when safe_divide(cte_product_ranked.cumulative_revenue, cte_product_ranked.grand_total_revenue) <= {{ var('pareto_a_threshold', 0.80) }} then 'A'
    when safe_divide(cte_product_ranked.cumulative_revenue, cte_product_ranked.grand_total_revenue) <= {{ var('pareto_b_threshold', 0.95) }} then 'B'
    else 'C'
  end as pareto_class
from cte_product_ranked 
left join cte_product_in_stock on cte_product_ranked.product_id = cte_product_in_stock.product_id
order by cte_product_ranked.revenue_rank
