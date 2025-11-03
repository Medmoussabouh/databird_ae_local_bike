SELECT
    cast(customer_id as int64) as customer_id,
    trim(first_name) AS customer_first_name,
    trim(last_name) AS customer_last_name,
    if(trim(phone) = 'NULL','',trim(phone)) as customer_phone,
    if(trim(email) = 'NULL','',trim(email)) as customer_email,
    trim(street) AS customer_street,
    trim(city) AS customer_city,
    trim(`state`) AS customer_state,
    cast(zip_code as int64) as customer_zip_code
FROM {{source('db_local_bike', 'customers')}}