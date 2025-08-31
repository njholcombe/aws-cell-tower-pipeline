CREATE EXTERNAL TABLE IF NOT EXISTS celldata.bronze_opencellid(
  radio string, mcc int, mnc int, area int, cell bigint,
  lon double, lat double, range int, samples int,
  created string, updated string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar'=',','quoteChar'='"')
LOCATION 's3://celldata-raw-w1/bronze/opencellid/'
TBLPROPERTIES ('has_encrypted_data'='true');
