##############################################
# File Name: check_nginxserver.sh
# Author: liuxiao
# Mail: liuxiao255@qq.com
# Created Time: 2016-08-20 10:44
##############################################
#Program function:Check Nginxserver Status Code.
#!/bin/bash

Nginxserver='http://www.baidu.com'

Check_Nginx_Server()
{
	echo -e "\e[1;34mNginxserver = \e[1;32m${Nginxserver}\e[0m"
	Status_code=`curl -m 5 -s -w %{http_code} ${Nginxserver} -o /dev/null`
	echo -e "\e[1;34mStatus_code = \e[1;32m${Status_code}\e[0m"
	if [ $Status_code -ne 200 ];then
		echo -e "\e[1;34mThe HTTP Status Code is abnormal,Please check your Nginxserver\e[0m"
	elif [ $Status_code -eq 200 ];then
		echo -e "\e[1;34mThe Nginxserver is OK\e[0m"
	fi
}

Check_Nginx_Server
