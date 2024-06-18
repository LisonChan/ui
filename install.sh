#!/bin/bash  
  
# 安装wget（如果尚未安装）  
apk add --no-cache wget  
  
# 下载并解压文件  
wget https://github.com/LisonChan/ui/releases/download/x-ui/amd64.tar.gz  
mkdir -p /root/x-ui  
tar zxvf amd64.tar.gz -C /root/x-ui --strip-components=1  # 假设解压到/root/x-ui，并去除顶层目录  
  
# 切换到x-ui目录  
cd /root/x-ui  
  
# 读取xui端口  
read -p "请输入xui端口: " port  
  
# 假设x-ui支持通过命令行参数设置端口，或者你需要手动编辑配置文件  
# 这里只是示例，具体设置方式需要根据x-ui的文档来确定  
# ./x-ui -port $port  # 如果x-ui支持通过命令行设置端口  
  
# 如果需要，你可以在这里创建或修改配置文件来设置端口  
  
# 创建并启动服务  
cat >/etc/init.d/x-ui << EOF  
#!/sbin/openrc-run  
  
command="/root/x-ui/x-ui"  # 假设x-ui可执行文件位于此路径  
command_args=""  # 如果需要，可以在这里添加命令行参数，如设置配置文件路径等  
pidfile="/run/x-ui.pid"  
  
name="x-ui"  
description="x-ui Service"  
  
start() {  
    ebegin "Starting \$name"  
    start-stop-daemon --start --background --pidfile \$pidfile --exec \$command \$command_args  
    eend \$?  
}  
  
stop() {  
    ebegin "Stopping \$name"  
    start-stop-daemon --stop --pidfile \$pidfile  
    eend \$?  
}  
  
EOF  
  
chmod +x /etc/init.d/x-ui  
rc-update add x-ui default  
rc-service x-ui start  
  
# 清理下载的压缩包  
rm -f amd64.tar.gz
