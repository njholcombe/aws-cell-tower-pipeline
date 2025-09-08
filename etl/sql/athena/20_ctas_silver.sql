
CREATE TABLE celldata.silver_opencellid
WITH (
  external_location='s3://celldata-curated-w1/silver/opencellid/',
  format='PARQUET',
  parquet_compression='SNAPPY',
  partitioned_by=ARRAY['ingest_date']
)
AS
WITH cleaned AS (
  SELECT
    upper(trim(radio)) AS radio,
    try_cast(mcc AS integer) AS mcc,
    lpad(cast(try_cast(mnc AS integer) AS varchar),3,'0') AS mnc,
    try_cast(area AS integer) AS area,
    try_cast(cell AS bigint)  AS cell,
    try_cast(lon  AS double)  AS lon,
    try_cast(lat  AS double)  AS lat,
    try_cast(range AS integer) AS range,
    try_cast(samples AS integer) AS samples,
    try_cast(created AS timestamp) AS created_ts,
    try_cast(updated AS timestamp) AS updated_ts,
    regexp_extract("$path",'ingest_date=([0-9\-]+)',1) AS ingest_date
  FROM celldata.bronze_opencellid
  WHERE try_cast(lon AS double) BETWEEN -180 AND 180
    AND try_cast(lat AS double) BETWEEN  -90 AND  90
),
dedup AS (
  SELECT *,
         row_number() OVER (
           PARTITION BY mcc,mnc,area,cell,radio,ingest_date
           ORDER BY coalesce(updated_ts,created_ts) DESC
         ) rn
  FROM cleaned
)
SELECT
  lower(to_hex(md5(to_utf8(
    concat_ws('-', cast(mcc AS varchar), mnc, cast(area AS varchar), cast(cell AS varchar), radio)
  )))) AS tower_id,
  radio,mcc,mnc,area,cell,lon,lat,range,samples,created_ts,updated_ts,ingest_date
FROM dedup
WHERE rn = 1;
