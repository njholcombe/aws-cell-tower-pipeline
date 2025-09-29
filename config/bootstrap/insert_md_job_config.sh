#!/bin/bash
aws dynamodb put-item \
  --table-name MD_JOB_CONFIG \
  --item file://insert_md_job_config.json
