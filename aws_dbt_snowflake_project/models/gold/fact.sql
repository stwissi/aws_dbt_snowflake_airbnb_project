{% set configs = [
    {'table': ref('obt'),
    'columns':'GOLD_obt.BOOKING_ID,GOLD_obt.LISTING_ID,GOLD_obt.HOST_ID,GOLD_obt.TOTAL_AMOUNT,GOLD_obt.ACCOMMODATES,GOLD_obt.BEDROOMS,GOLD_obt.BATHROOMS,GOLD_obt."Response Rate"',
    'alias':'GOLD_obt'
    },
    {'table': ref('dim_listings'),
    'columns':'',
    'alias':'GOLD_listings',
    'join_condition':"GOLD_obt.listing_id=GOLD_listings.listing_id"
    },
    {'table': ref('dim_hosts'),
    'columns':'',
    'alias':'GOLD_hosts',
    'join_condition':"GOLD_listings.host_id=GOLD_hosts.host_id"
    }
] %}

SELECT 
{{configs[0]['columns']}} 
FROM 
{% for config in configs %}
{% if loop.first %}
{{config.table}} as {{config.alias}}
{% else %}
LEFT JOIN {{config.table}} as {{config.alias}} ON {{config.join_condition}}
{% endif %}
{% endfor %}