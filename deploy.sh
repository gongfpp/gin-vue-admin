#!/bin/bash
# 变量设置
GO_PORT=8888       # Go 后端端口
VUE_PORT=8080      # Vue3 前端端口


cd /home/ubuntu/project/gin-vue-admin || { echo "Failed to cd into the project directory"; exit 1; }

# 确保 deploy.log 存在
LOG_FILE="/home/ubuntu/project/gin-vue-admin/deploy.log"
# 如果日志文件不存在则创建
[ ! -f "$LOG_FILE" ] && touch "$LOG_FILE"

# 执行 git pull 并记录输出
echo " 
****开始执行自动化部署**** 
Pulling latest changes from main branch..." >> "$LOG_FILE"
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
# 关闭 Go 后端服务
echo "Stopping Go backend..."
GO_PID=$(lsof -t -i:$GO_PORT)
if [ -n "$GO_PID" ]; then
    kill -9 $GO_PID
    echo "Go backend stopped."
else
    echo "Go backend is not running."
fi
cd /home/ubuntu/project/gin-vue-admin/server
tmux new-session -d -s backend 'go run /home/ubuntu/project/gin-vue-admin/server/main.go >> server.log  '


# 重新部署前端
# 关闭 Vue3 前端服务
echo "Stopping Vue3 frontend..."
VUE_PID=$(lsof -t -i:$VUE_PORT)
if [ -n "$VUE_PID" ]; then
    kill -9 $VUE_PID
    echo "Vue3 frontend stopped."
else
    echo "Vue3 frontend is not running."
fi
cd /home/ubuntu/project/gin-vue-admin/web
tmux new-session -d -s frontend 'npm run serve >> web.log  '

