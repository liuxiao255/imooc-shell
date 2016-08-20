##############################################
# File Name: master_control.sh
# Author: liuxiao
# Mail: liuxiao255@qq.com
# Created Time: 2016-08-16 14:55
##############################################
#!/bin/bash

declare -A ssharray
i=1
numbers="0"

for script_file in `ls -I "master_control.sh" ./`
do
	echo -e "\e[1;34mThe Script: ${i} ==> \e[0m""\e[1;35m${script_file}\e[0m"
	grep -E "^\#Program function" ${script_file}
	ssharray[$i]=${script_file}
	numbers="${numbers} | ${i}"
	i=$((i+1))
done

while true
do
	read -p "Please input a number,the '0' is exit, [ ${numbers} ]: " execshell
	if [[ ! ${execshell} =~ ^[0-9]+ ]];then
		exit 0
	fi
	if [ $execshell -eq 0 ];then
		exit 0
	else
		/bin/bash ./${ssharray[$execshell]}
	fi
done
