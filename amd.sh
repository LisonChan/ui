#!/bin/bash
wget https://github.com/LisonChan/ui/releases/download/x-ui/amd64.tar.gz
tar zxvf amd64.tar.gz

cd /root/x-ui  

read -p "请输入xui端口: " port

./x-ui  setting -port $port  

touch /etc/systemd/system/ui.service 

cat>/etc/systemd/system/ui.service<< EOF
[Unit]
Description=x-ui Service
After=network.target
Wants=network.target

[Service]
Type=simple
WorkingDirectory=/root/x-ui/
ExecStart=/root/x-ui/x-ui
Restart=on-failure
RestartSec=30s
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF
chmod 777 /etc/systemd/system/ui.service    
systemctl enable ui.service  
systemctl start ui.service    
systemctl restart ui.service   
rm -rf /root/amd64.tar.gz
