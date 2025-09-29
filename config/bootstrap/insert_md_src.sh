#!/bin/bash
aws dynamodb put-item \
  --table-name MD_SRC \
  --item file://insert_md_src.json
