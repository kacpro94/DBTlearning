select 
    zone_id as region_id,
    zone_name as region_name,
    borough as borough_name,
    zone_geom as region_geom
from 
    {{source('sadp_raw', 'taxi_zone_geom')}}