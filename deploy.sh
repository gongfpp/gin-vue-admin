#!/bin/bash
cd /home/ubuntu/project/gin-vue-admin || { echo "Failed to cd into the project directory"; exit 1; }

# 确保 deploy.log 存在
LOG_FILE="deploy.log"
# 如果日志文件不存在则创建
[ ! -f "$LOG_FILE" ] && touch "$LOG_FILE"

# 执行 git pull 并记录输出
echo "Pulling latest changes from main branch..." >> "$LOG_FILE"
if git pull origin main 2>&1 | tee -a "$LOG_FILE"; then
    # 如果部署成功，记录成功日志
    echo "Deployed successfully at $(date)  " >> "$LOG_FILE"
else
    # 如果部署失败，记录失败日志
    echo "Failed to deploy at $(date)  " >> "$LOG_FILE"
fi

# 在日志文件中添加换行
echo -e "
" >> "$LOG_FILE"

# 重新部署服务器

# 重新部署前端

