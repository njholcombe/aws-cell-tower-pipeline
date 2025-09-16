#!/bin/bash

# Insert auth_type
aws dynamodb put-item \
  --table-name MD_SRC \
  --item '{
    "detail_value": {"S": "token"},
    "detail_name": {"S": "auth_type"},
    "source_id": {"N": "1"}
  }'
