  SELECT
    ooi.order_id,ooi.order_date,
    ooi.product_brand_name, ooi.product_category_name, ooi.product_name,
    ooi.order_store_id,s.store_state, s.store_city, s.store_name,
    ooi.order_staff_id, CONCAT(stf.staff_first_name ," ", stf.staff_last_name) AS staff_full_name,
    ooi.order_customer_id, CONCAT(c.customer_first_name ," ", c.customer_last_name) AS customer_full_name,
    ooi.product_id, ooi.revenue,ooi.order_item_quantity, ooi.order_item_list_price
  FROM {{ ref('int_local_bike__order_order_items') }} ooi
  INNER JOIN {{ ref('stg_local_bike__stores') }} AS s on ooi.order_store_id = s.store_id
  INNER JOIN {{ ref('stg_local_bike__staffs') }} AS stf on ooi.order_staff_id = stf.staff_id
  INNER JOIN {{ ref('stg_local_bike__customers') }} AS c on ooi.order_customer_id = c.customer_id