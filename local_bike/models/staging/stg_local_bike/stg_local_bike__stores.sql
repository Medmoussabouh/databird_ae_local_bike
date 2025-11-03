SELECT
    cast(store_id as int64) as store_id,
    trim(store_name) AS store_name,
    if(trim(phone) = 'NULL','',trim(phone)) as store_phone,
    if(trim(email) = 'NULL','',trim(email)) as store_email,
    trim(street) AS store_street,
    trim(city) AS store_city,
    trim(`state`) AS store_state,
    cast(zip_code as int64) as store_zip_code
FROM {{source('db_local_bike', 'stores')}}
