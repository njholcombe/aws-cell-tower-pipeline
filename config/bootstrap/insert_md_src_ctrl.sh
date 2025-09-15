#!/bin/bash
aws dynamodb put-item \
  --table-name MD_SRC_CTRL \
  --item file://insert_md_src_ctrl.json
