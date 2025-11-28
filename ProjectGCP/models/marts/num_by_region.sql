with region_count as(
    select
    pickup_region_name as pickup_reg_name,
    COUNT(*) as num_trips
    from {{ref('build')}}
    group by 1
)

select
    *
from region_count