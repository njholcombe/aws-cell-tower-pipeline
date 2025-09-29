#!/bin/bash
aws dynamodb put-item \
  --table-name MD_TGT_DET \
  --item file://insert_md_tgt_det.json
