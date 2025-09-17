#!/bin/bash

# Insert auth_type
aws dynamodb put-item \
  --table-name MD_SRC \
  --item '{
  "enabled": {"BOOL": true},
  "source_name": {"S": "OpenCellID"},
  "source_id": {"N": "1"}
}'
