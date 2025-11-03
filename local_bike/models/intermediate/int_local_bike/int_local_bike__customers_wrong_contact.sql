SELECT
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_phone,
    customer_email,
        CASE WHEN not regexp_contains(customer_phone, r'^\(\d{3}\)\s\d{3}-\d{4}$')
        THEN False
        ELSE True
    END AS phone_validation, 
    CASE WHEN not regexp_contains(customer_email, r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
        THEN False
        ELSE True
    END AS email_validation,

FROM {{ ref('stg_local_bike__customers') }}
WHERE not regexp_contains(customer_email, r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
OR not regexp_contains(customer_phone, r'^\(\d{3}\)\s\d{3}-\d{4}$')