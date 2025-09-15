#!/bin/bash
aws dynamodb put-item \
  --table-name MD_DATASETS \
  --item file://insert_md_datasets.json
