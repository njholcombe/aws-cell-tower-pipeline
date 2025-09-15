#!/bin/bash
aws dynamodb put-item \
  --table-name MD_JOBS \
  --item file://insert_md_jobs.json
