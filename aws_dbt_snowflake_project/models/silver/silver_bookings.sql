{{ config(materialized='incremental', unique_key='Booking_ID') }}

select booking_id,
    listing_id,
    BOOKING_DATE,
    {{multiply('NIGHTS_BOOKED','BOOKING_AMOUNT',2)}} + CLEANING_FEE + SERVICE_FEE as TOTAL_AMOUNT,
    BOOKING_STATUS,
    CREATED_AT
from {{ref("bronze_bookings")}}
    