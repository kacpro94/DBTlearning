{{ config(
    materialized='table'
) }}

select
    green.*,
    region.region_name as pickup_region_name,
    region_drop.region_name as dropoff_region_name
from {{ref('stg_green_taxi')}} as green
inner join {{ref('stg_region')}} as region
on green.pickup_location_id = region.region_id
inner join {{ref('stg_region')}} as region_drop
on green.dropoff_location_id = region_drop.region_id