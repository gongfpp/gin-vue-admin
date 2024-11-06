# 学习笔记
## ps -aux 输出的字段含义：
字段	含义
USER	启动该进程的用户名（用户ID）
PID	进程的 ID（Process ID），每个进程都有一个唯一的 PID
%CPU	该进程使用的 CPU 时间的百分比（相对于 CPU 总时间的占比）
%MEM	该进程使用的物理内存的百分比（相对于系统总内存的占比）
VSZ	进程占用的虚拟内存大小，单位为 KB
RSS	进程占用的常驻内存（Physical Memory）大小，单位为 KB
TTY	进程所在的终端（TTY，TeleTYpewriter），指进程在终端中运行的显示位置。常见的如 /dev/tty1。对于后台进程通常显示为 ?。
STAT	进程的状态，代表进程的当前运行状态。这个字段可能包含多个字母，表示不同的状态。
START	进程启动的时间，通常是启动该进程的日期和时间（或者是系统启动后的时间）
TIME	进程使用的累计 CPU 时间
COMMAND	启动该进程的命令及其参数
STAT 字段的含义
STAT 字段显示进程的当前状态。这个状态由一个或多个字母组成，表示进程的不同状态。常见的状态字母包括：

R：Running，正在运行，或者在运行队列中等待运行。
S：Sleeping，休眠，表示进程当前未在执行而是等待某些事件（如 I/O 操作完成）。
D：Uninterruptible Sleep，无法中断的睡眠状态，通常是由于进程等待磁盘 I/O 或硬件设备操作而无法被打断。
T：Stopped，已停止的进程，通常由 SIGSTOP 或 kill -STOP 信号终止。
Z：Zombie，僵尸进程，表示进程已终止，但其父进程尚未调用 wait() 来清理其状态。
I：Idle，空闲状态（通常表示内核线程）。
W：Paging，进程正在等待内存交换（Page Out）。


