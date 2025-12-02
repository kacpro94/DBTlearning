{{ config(materialized='view') }}

WITH source_data AS (
    SELECT 
        -- Dostosowanie nazw kolumn (Plik Parquet ma CamelCase)
        VendorID AS vendor_id,
        lpep_pickup_datetime AS pickup_at,
        lpep_dropoff_datetime AS dropoff_at,
        PULocationID AS pickup_location_id,
        DOLocationID AS dropoff_location_id,
        passenger_count,
        trip_distance,
        fare_amount,
        tip_amount,
        total_amount,
        payment_type
    FROM 
        -- Bezpośredni link do pliku Parquet dla DuckDB
        'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-01.parquet'
)

SELECT 
    *,
    -- Generowanie klucza w DuckDB (md5 jest prostsze i wystarczające)
    md5(concat(vendor_id, pickup_at)) AS trip_key
FROM source_data
WHERE trip_distance > 0 
  AND total_amount > 0