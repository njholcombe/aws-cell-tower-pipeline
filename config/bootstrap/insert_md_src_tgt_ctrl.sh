#!/bin/bash
aws dynamodb put-item \
  --table-name MD_SRC_TGT_CTRL \
  --item file://insert_md_src_tgt_ctrl.json
