CREATE TABLE celldata.silver_opencellid
WITH (
  format='PARQUET',
  parquet_compression='SNAPPY',
  external_location='s3://REPLACE-CUR/silver/opencellid/',
  partitioned_by=ARRAY['ingest_date']
) AS
SELECT radio,mcc,mnc,area,cell,lon,lat,range,samples,
       try_cast(created as timestamp) created_ts,
       try_cast(updated as timestamp) updated_ts,
       regexp_extract("$path",'ingest_date=([0-9\-]+)',1) ingest_date
FROM celldata.bronze_opencellid;
