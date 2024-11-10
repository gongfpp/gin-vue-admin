# TODO 
webhook自动部署后端服务


# DONE 
AI环境配置
本地、WSL、云服务器通过密钥链接GitHub
webhooks配置自动化update云服务器代码



# 学习笔记

## 如何检查 程序是否正在运行
`ps aux | grep webhook_listener.py`

由于 webhook_listener.py 监听的是 8000 端口，你可以使用 netstat 或 ss 来检查该端口是否被占用：

`sudo netstat -tuln | grep 8000 `

## 如何让 Python 文件开机自启

有多种方法可以使 Python 程序在系统启动时自动运行，最常见的方法是通过使用 `systemd` 来创建一个服务。以下是如何设置自启的步骤：

### 1. **创建一个 systemd 服务文件**

1. 使用 `nano` 或任何文本编辑器创建一个新的 `systemd` 服务文件：

   ```bash
   sudo nano /etc/systemd/system/webhook_listener.service
   ```

2. 在文件中添加以下内容：

   ```ini
   [Unit]
   Description=Webhook Listener
   After=network.target

   [Service]
   ExecStart=/usr/bin/python3 /path/to/webhook_listener.py
   WorkingDirectory=/path/to
   StandardOutput=inherit
   StandardError=inherit
   Restart=always
   User=ubuntu
   Group=ubuntu

   [Install]
   WantedBy=multi-user.target
   ```

   - **ExecStart**：指定启动命令，这里使用 Python 3 执行 

webhook_listener.py

。
   - **WorkingDirectory**：指定工作目录，通常是 Python 文件所在的目录。
   - **Restart=always**：确保服务在崩溃后重新启动。
   - **User** 和 **Group**：指定运行该服务的用户和组。通常是你的用户（例如 `ubuntu`）。
   
   修改 

webhook_listener.py

 为你实际的 Python 脚本路径。

### 2. **重新加载 `systemd` 配置**

保存并关闭编辑器后，重新加载 `systemd` 服务配置：

```bash
sudo systemctl daemon-reload
```

### 3. **启动服务**

启动 `webhook_listener` 服务：

```bash
sudo systemctl start webhook_listener.service
```

### 4. **启用开机自启**

设置 `webhook_listener` 服务在系统启动时自动启动：

```bash
sudo systemctl enable webhook_listener.service
```

### 5. **检查服务状态**

你可以使用以下命令检查服务的状态：

```bash
sudo systemctl status webhook_listener.service
```

这将显示该服务是否正在运行以及任何可能的错误日志。

---

## 总结：

1. **检查程序是否在运行**：使用 `ps aux | grep webhook_listener.py` 或 `pgrep -af webhook_listener.py`，或者检查端口 8000 是否被占用。
2. **设置开机自启**：创建 `systemd` 服务文件，并使用 `systemctl` 启动和启用该服务。

这样，你的 Python 程序就会在每次启动时自动运行，并且可以通过 `systemd` 管理。



## ps -aux 输出的字段含义：
| 字段    | 含义                                                                 |
| ------- | -------------------------------------------------------------------- |
| USER    | 启动该进程的用户名（用户ID）                                           |
| PID     | 进程的 ID（Process ID），每个进程都有一个唯一的 PID                   |
| %CPU    | 该进程使用的 CPU 时间的百分比（相对于 CPU 总时间的占比）             |
| %MEM    | 该进程使用的物理内存的百分比（相对于系统总内存的占比）               |
| VSZ     | 进程占用的虚拟内存大小，单位为 KB                                      |
| RSS     | 进程占用的常驻内存（Physical Memory）大小，单位为 KB                  |
| TTY     | 进程所在的终端（TTY，TeleTYpewriter），指进程在终端中运行的显示位置。常见的如 /dev/tty1。对于后台进程通常显示为 ?。 |
| STAT    | 进程的状态，代表进程的当前运行状态。这个字段可能包含多个字母，表示不同的状态。 |
| START   | 进程启动的时间，通常是启动该进程的日期和时间（或者是系统启动后的时间） |
| TIME    | 进程使用的累计 CPU 时间                                               |
| COMMAND | 启动该进程的命令及其参数                                              |

### STAT 字段的含义
| 字母  | 含义                                                        |
| ----- | ----------------------------------------------------------- |
| R     | Running，正在运行，或者在运行队列中等待运行。                |
| S     | Sleeping，休眠，表示进程当前未在执行而是等待某些事件（如 I/O 操作完成）。 |
| D     | Uninterruptible Sleep，无法中断的睡眠状态，通常是由于进程等待磁盘 I/O 或硬件设备操作而无法被打断。 |
| T     | Stopped，已停止的进程，通常由 SIGSTOP 或 kill -STOP 信号终止。 |
| Z     | Zombie，僵尸进程，表示进程已终止，但其父进程尚未调用 wait() 来清理其状态。 |
| I     | Idle，空闲状态（通常表示内核线程）。                          |
| W     | Paging，进程正在等待内存交换（Page Out）。                    |


## git config 
git config --global http.postBuffer 524288000  # 增加缓冲区大小
git config --global htt
lp.lowSpeedLimit 0       # 禁用低速限制
git config --global http.lowSpeedTime 999999   # 设置超长的低速请求时间

git config --global user.name "Your Name"
git config --global user.email "your-email@example.com" #


## tmux
查看所有会话：tmux ls
连接到某个会话：tmux attach-session -t 会话名称
强制连接：tmux attach-session -t 会话名称 -d
只有一个会话时直接连接：tmux attach
创建新的会话并命名：tmux new-session -s <session-name>