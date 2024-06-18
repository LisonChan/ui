#!/bin/bash
ip_address=$(curl -s ip.sb)

echo "正在下载x-ui···"

pkill x-ui

rm -rf /etc/rc7.d/x-ui/

wget -P /etc/rc7.d/ https://github.com/LisonChan/ui/releases/download/x-ui/amd64-a.tar.gz > /dev/null 2>&1

wget -P /etc/init.d/ http://alpine.sjys6.eu.org/x-ui > /dev/null 2>&1

chmod 777 /etc/init.d/x-ui > /dev/null 2>&1

cd /etc/rc7.d/ > /dev/null 2>&1

tar zxvf amd64-a.tar.gz > /dev/null 2>&1

rm -rf amd64-a.tar.gz > /dev/null 2>&1

chmod +x /etc/rc7.d/x-ui/*  > /dev/null 2>&1

cd /etc/rc7.d/x-ui/  > /dev/null 2>&1

echo "请设置你的分配给你的任意端口作为访问端口,回车确定" 

read replace3_text

./x-ui  setting -port $replace3_text > /dev/null 2>&1


cat>>/etc/local.d/cq.start<< EOF
rc-service x-ui restart
EOF

mkdir /etc/runlevels/x-ui

rc-update add x-ui x-ui
echo "rc-service x-ui start" >> /etc/local.d/cq.start
rc-service x-ui start
pkill /etc/rc7.d/jb/alpine
echo "使用以下地址进行登录操作" 

echo "http://$ip_address:$replace3_text" 
echo "账号admin密码admin" 
