#!/bin/bash

# Results Zone
aws dynamodb put-item \
  --table-name MD_TGT_CTRL \
  --item '{
    "enabled": {"BOOL": true},
    "target_location": {"S": "s3://celldata-results-w1"},
    "target_id": {"N": "3"},
    "target_type": {"S": "s3"},
    "target_name": {"S": "Results Zone"}
  }'

# Curated Zone
aws dynamodb put-item \
  --table-name MD_TGT_CTRL \
  --item '{
    "enabled": {"BOOL": true},
    "target_location": {"S": "s3://celldata-curated-w1"},
    "target_id": {"N": "2"},
    "target_type": {"S": "s3"},
    "target_name": {"S": "Curated Zone"}
  }'

# Raw Zone
aws dynamodb put-item \
  --table-name MD_TGT_CTRL \
  --item '{
    "enabled": {"BOOL": true},
    "target_location": {"S": "s3://celldata-raw-w1"},
    "target_id": {"N": "1"},
    "target_type": {"S": "s3"},
    "target_name": {"S": "Raw Zone"}
  }'
