#!/bin/bash
cd /home/ubuntu/project/gin-vue-admin

# 确保 deploy.log 存在
LOG_FILE="deploy.log"
[ ! -f "$LOG_FILE" ] && touch "$LOG_FILE"

# 执行 git pull 并记录输出
if git pull origin main 2>&1 | tee -a "$LOG_FILE"; then
    echo "Deployed successfully at $(date)" >> "$LOG_FILE"
else
    echo "Failed to deploy at $(date)" >> "$LOG_FILE"
fi

# 重新部署服务器

