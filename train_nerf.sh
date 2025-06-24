#!/bin/bash

source activate nerfstudio

# 清理旧日志
rm -f cpu_gpu_log.csv

# 开启后台采样（每1秒记录一次）
(
    echo "timestamp,cpu_percent,gpu_percent"
    while true; do
        timestamp=$(date +%s)
        cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')  # $8 是 idle 百分比
        gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ sum += $1 } END { print sum / NR }')
        echo "$timestamp,$cpu,$gpu"
        sleep 1
    done
) > cpu_gpu_log.csv &
monitor_pid=$!

# 获取开始时间
start=$(date +%s%3N)

# 运行主程序
ns-train nerfacto \
--vis viewer+tensorboard nerfstudio-data \
--data ./processed_data \
--eval-mode fraction \
--train-split-fraction 0.8

# 获取结束时间
end=$(date +%s%3N)
duration=$((end - start))

# 杀掉监控进程
kill $monitor_pid

echo "程序运行总时间：$duration 毫秒"

# 用 awk 计算平均 CPU/GPU 使用率
cpu_avg=$(awk -F, 'NR>1 {sum+=$2} END {print sum/(NR-1)}' cpu_gpu_log.csv)
gpu_avg=$(awk -F, 'NR>1 {sum+=$3} END {print sum/(NR-1)}' cpu_gpu_log.csv)

echo "CPU 平均使用率：$cpu_avg%"
echo "GPU 平均使用率：$gpu_avg%"