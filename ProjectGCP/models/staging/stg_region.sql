{{ config(materialized='view') }}

SELECT 
    LocationID AS region_id,
    Zone AS region_name,
    Borough AS borough_name
FROM 
    -- DuckDB potrafi czytać CSV prosto z linku!
    'https://d37ci6vzurychx.cloudfront.net/misc/taxi+_zone_lookup.csv'