#!/bin/bash

source activate nerfstudio

mkdir -p processed_data_2
mv colmap processed_data_2/

# 生成 nerfstudio-data 数据
ns-process-data images \
--data ./images_2 \
--output-dir ./processed_data_2 \
--skip-colmap \
--colmap-model-path ./colmap/sparse/0
