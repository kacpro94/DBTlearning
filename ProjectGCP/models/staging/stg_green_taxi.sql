-- models/staging/stg_green_trips.sql

{{ config(
    materialized='view' 
) }}

SELECT
    vendor_id,
    -- Zmieniamy nazwy kolumn na bardziej przyjazne i standaryzowane
    rate_code AS rate_code_id, 
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,
    -- Wybieramy daty
    DATETIME(pickup_datetime) AS pickup_at,
    DATETIME(dropoff_datetime) AS dropoff_at,
    pickup_location_id,
    dropoff_location_id,
    -- Dodajemy unikalny klucz dla każdej transakcji (best practice)
    TO_HEX(SHA256(CONCAT(CAST(vendor_id AS STRING), CAST(pickup_datetime AS STRING)))) AS trip_key 
FROM
    -- PEŁNA ścieżka do publicznej tabeli taksówek
    {{source('sadp_raw', 'tlc_green_trips_2022')}}

