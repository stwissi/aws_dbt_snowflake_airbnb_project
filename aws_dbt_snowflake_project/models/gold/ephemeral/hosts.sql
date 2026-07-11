{{
    config(
        materialized = 'ephemeral',
    )
}}

WITH HOSTS AS (
    SELECT
    HOST_ID,
    HOST_NAME,
    "Host Since",
    "Is Superhost",
    "Response Rate",
    "Response Quality",
    "Created_at"
    FROM {{ ref('silver_hosts') }}
)
SELECT * FROM HOSTS
