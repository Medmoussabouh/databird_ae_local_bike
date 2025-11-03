
SELECT
    cast(order_id as int64) as order_id,
    cast(customer_id as int64) as order_customer_id,
    cast(order_status as int64) as order_status,
    cast(order_date as date) as order_date,
    cast(required_date as date) as order_required_date,
    cast(nullif(lower(trim(shipped_date)), 'null') as date)  as order_shipped_date,
    cast(store_id as int64) as order_store_id,
    cast(staff_id as int64) as order_staff_id
FROM {{source('db_local_bike', 'orders')}}
