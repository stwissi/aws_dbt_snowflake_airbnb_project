{{
    config(
        materialized = 'ephemeral',
    )
}}

WITH LISTINGS AS (
    SELECT
    LISTING_ID,
    HOST_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMMODATES,
    BEDROOMS,
    BATHROOMS,
    PRICE_PER_NIGHT,
    PRICE_PER_NIGHT_TAG,
    CREATED_AT
    FROM {{ ref('silver_listings') }}
)
SELECT * FROM LISTINGS
