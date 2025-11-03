SELECT
    cast(staff_id as int64) as staff_id,
    trim(first_name) AS staff_first_name,
    trim(last_name) AS staff_last_name,
    if(trim(phone) = 'NULL','',trim(phone)) as staff_phone,
    if(trim(email) = 'NULL','',trim(email)) as staff_email,
    cast(active as bool) as staff_is_active,
    cast(store_id as int64) as staff_store_id,
    if(manager_id = 'NULL',null, cast(manager_id as int64)) as staff_manager_id,
FROM {{source('db_local_bike', 'staffs')}}
