#!/bin/bash
aws dynamodb put-item \
  --table-name MD_TGT \
  --item file://insert_md_tgt.json
