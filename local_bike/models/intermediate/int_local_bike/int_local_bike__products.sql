SELECT 
    p.*,
    b.brand_name AS product_brand_name,
    c.category_name AS product_category_name
FROM {{ ref('stg_local_bike__products') }} AS p
INNER JOIN {{ ref('stg_local_bike__brands') }} AS b 
    ON p.product_brand_id = b.brand_id
INNER JOIN {{ ref('stg_local_bike__categories') }} AS c
    ON p.product_category_id = c.category_id