{% set configs = [
    {'table': ref('silver_bookings'),
    'columns':'silver_bookings.*',
    'alias':'silver_bookings'
    },
    {'table': ref('silver_listings'),
    'columns':'silver_listings.HOST_ID,silver_listings.PROPERTY_TYPE,silver_listings.ROOM_TYPE,silver_listings.CITY,silver_listings.COUNTRY,silver_listings.ACCOMMODATES,silver_listings.BEDROOMS,silver_listings.BATHROOMS,silver_listings.PRICE_PER_NIGHT,silver_listings.PRICE_PER_NIGHT_TAG,silver_listings.CREATED_AT AS LISTING_CREATED_AT',
    'alias':'silver_listings',
    'join_condition':"silver_bookings.listing_id=silver_listings.listing_id"
    },
    {'table': ref('silver_hosts'),
    'columns':'silver_hosts.HOST_NAME,silver_hosts."Host Since",silver_hosts."Is Superhost",silver_hosts."Response Rate",silver_hosts."Response Quality",silver_hosts."Created_at" AS HOST_CREATED_AT',
    'alias':'silver_hosts',
    'join_condition':"silver_listings.host_id=silver_hosts.host_id"
    }
] %}

SELECT {% for config in configs %}
{{config.columns}} {% if not loop.last %}, {% endif %}
{% endfor %}
FROM 
{% for config in configs %}
{% if loop.first %}
{{config.table}} as {{config.alias}}
{% else %}
LEFT JOIN {{config.table}} as {{config.alias}} ON {{config.join_condition}}
{% endif %}
{% endfor %}