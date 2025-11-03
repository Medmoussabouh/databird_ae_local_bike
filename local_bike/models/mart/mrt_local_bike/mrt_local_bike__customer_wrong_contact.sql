SELECT 
    *,
    CASE 
        WHEN email_validation is False and phone_validation is False THEN 'email , phone'
        WHEN email_validation is True and phone_validation is False THEN 'phone'
        WHEN email_validation is False and phone_validation is True THEN 'email'
    END AS invalid_fields

FROM {{ ref('int_local_bike__customers_wrong_contact') }}