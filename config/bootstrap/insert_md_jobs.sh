#!/bin/bash
aws dynamodb put-item \
  --table-name MD_JOBS \
  --item file://open_cellid_md_jobs.json
