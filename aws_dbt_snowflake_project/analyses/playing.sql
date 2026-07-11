-- This query shows you exactly what new data is sitting in the source table 
-- that has NOT YET been loaded into your bronze table.

SELECT * 
FROM {{ source('staging', 'bookings') }}
WHERE created_at > (
    SELECT COALESCE(MAX(created_at), '1900-01-01') 
    FROM {{ ref('bronze_bookings') }}
)
