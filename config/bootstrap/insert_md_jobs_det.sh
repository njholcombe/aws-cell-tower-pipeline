#!/bin/bash

# Insert expected_header
aws dynamodb put-item \
  --table-name MD_JOBS_DET \
  --item '{
    "job_id": {"N": "1"},
    "param_value": {"S": "radio,mcc,mnc,lac,cid,lat,lon"},
    "param_name": {"S": "expected_header"}
  }'

# Insert param_name
aws dynamodb put-item \
  --table-name MD_JOBS_DET \
  --item '{
    "job_id": {"N": "1"},
    "param_value": {"S": "/celldata/opencellid/token"},
    "param_name": {"S": "param_name"}
  }'

# Insert raw_bucket
aws dynamodb put-item \
  --table-name MD_JOBS_DET \
  --item '{
    "job_id": {"N": "1"},
    "param_value": {"S": "celldata-raw-w1"},
    "param_name": {"S": "raw_bucket"}
  }'
