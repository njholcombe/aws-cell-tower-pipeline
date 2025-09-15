#!/bin/bash

# Insert auth_type
aws dynamodb put-item \
  --table-name MD_SRC_DET \
  --item '{
    "detail_value": {"S": "token"},
    "detail_name": {"S": "auth_type"},
    "source_id": {"N": "1"}
  }'

# Insert connection_info
aws dynamodb put-item \
  --table-name MD_SRC_DET \
  --item '{
    "detail_value": {"S": "https://opencellid.org/downloadFile"},
    "detail_name": {"S": "connection_info"},
    "source_id": {"N": "1"}
  }'
