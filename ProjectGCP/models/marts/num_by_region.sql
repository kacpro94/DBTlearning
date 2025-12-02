{{ config(materialized='table') }}

WITH trips AS (
    SELECT * FROM {{ ref('stg_green_taxi') }}
),

regions AS (
    SELECT * FROM {{ ref('stg_region') }}
)

SELECT
    r.region_name,
    r.borough_name,
    COUNT(t.trip_key) as num_trips,
    SUM(t.total_amount) as total_revenue,
    AVG(t.trip_distance) as avg_distance
FROM trips t
-- Łączymy wycieczki z regionami po ID
LEFT JOIN regions r ON t.pickup_location_id = r.region_id
GROUP BY 1, 2
ORDER BY 3 DESC