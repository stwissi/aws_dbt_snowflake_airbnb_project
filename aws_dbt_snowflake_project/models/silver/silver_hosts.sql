{{config(materialized = 'incremental', unique_key = 'HOST_ID')}}

SELECT 
HOST_ID,
REPLACE(HOST_NAME, ' ', '_') AS HOST_NAME,
HOST_SINCE AS "Host Since",
IS_SUPERHOST AS "Is Superhost",
RESPONSE_RATE as "Response Rate",
CASE 
WHEN RESPONSE_RATE > 95 THEN 'VERY GOOD'
WHEN RESPONSE_RATE > 80 THEN 'GOOD'
WHEN RESPONSE_RATE > 60 THEN 'FAIR'
ELSE 'POOR'
END AS "Response Quality",
CREATED_AT as "Created_at"
FROM {{ref("bronze_hosts")}}
