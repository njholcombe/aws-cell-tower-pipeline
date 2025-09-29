#!/bin/bash
aws dynamodb put-item \
  --table-name MD_SRC_DET \
  --item file://insert_md_src_det.json
