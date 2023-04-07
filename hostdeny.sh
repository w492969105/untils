#!/bin/sh

#登录失败次数大于10的ip
IP=$(awk '/Failed/{print $(NF-3)}' /var/log/secure | sort |uniq -c |awk '{if($1>3) print $2}')
hostdeny=/etc/hosts.deny

for i in $IP
do
    #如果ip不存在，则写入deny文件
    if [ ! $(grep $i $hostdeny) ];then
        echo "sshd:$i" >> $hostdeny
    fi
done
