##############################################
# File Name: system_info.sh
# Author: liuxiao
# Mail: liuxiao255@qq.com
# Created Time: 2016-08-16 19:30
##############################################
#!/bin/bash
#Program function:Display some system information.
clear
OS_bit=$(uname -m)
	echo -e "\e[1;34mOS_bit ==> \e[1;32m$OS_bit\e[0m"
OS_release=$(lsb_release -a | grep Description | cut -f 2)
	echo -e "\e[1;34mOS_release ==> \e[1;32m$OS_release\e[0m"
Kernel_release=$(uname -r)
	echo -e "\e[1;34mKernel_release ==> \e[1;32m$Kernel_release\e[0m"

echo

#Network card info
Net_card_name=$(ip addr | grep inet | awk '{print $NF}')
Net_card_ip=$(ip addr | grep inet | awk '{print $2}' | cut -f 1 -d "/")
i=0;j=0
for name in $Net_card_name   #将所有网卡的名称放入name_array数组中
do
	name_array[i]=$name
	i=$((i+1))
done
for ip in $Net_card_ip   #将所有网卡的IP放入ip_array数组中
do
	ip_array[j]=$ip
	j=$((j+1))
done
i=0;j=0
for time in $Net_card_name   #打印网卡名称和对应的IP，time为控制循环次数的变量
do
	echo -e "\e[1;34m${name_array[i]} ==> \e[1;32m${ip_array[j]}\e[0m" 
	i=$((i+1));j=$((j+1))
done

echo
#Network status
ping -c 2 www.baidu.com &>/dev/null && echo -e "\e[1;34mNetwork connection is OK\e[0m" || echo -e "\e[1;34mNetwork connection is False\e[0m"

echo
#Logged Users
echo -e "\e[1;34mLogged Users\e[0m"
echo -e "\e[1;34m`who`\e[0m"
echo

#Mem_usages
system_mem_usage=$(awk '/MemTotal/{total=$2}/MemFree/{free=$2}END{print (total-free)/1024}' /proc/meminfo)  #系统已经使用的内存
apps_mem_usage=$(awk '/MemTotal/{total=$2}/MemFree/{free=$2}/^Cache/{cached=$2}/Buffers/{buffers=$2}END{print (total-free-cached-buffers)/1024}' /proc/meminfo)  #应用程序使用的内存
echo -e "\e[1;34mSystem_mem_usage ==> \e[1;32m${system_mem_usage}M\e[0m"
echo -e "\e[1;34mApps_mem_usage ==> \e[1;32m${apps_mem_usage}M\e[0m"
echo

#Load average
load_average=$(top -n 1 -b | grep "load average:" | awk '{print $12 $13 $14}')
echo -e "\e[1;34mLoad_average ==> \e[1;32m${load_average}\e[0m"
echo

#Disk info
disk_info=$(df -hP | grep -vE "Filesystem|tmpfs" | awk '{print $1 "  " $5}')
echo -e "\e[1;34mdisk_info:\n\e[1;32m${disk_info}\e[0m"
