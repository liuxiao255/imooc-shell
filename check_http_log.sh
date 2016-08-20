##############################################
# File Name: chech_http_log.sh
# Author: liuxiao
# Mail: liuxiao255@qq.com
# Created Time: 2016-08-19 21:59
##############################################
#Program function:Nginx's log analysis
#!/bin/bash

Logfile_path='/home/wwwroot/index/log/access.log'

Check_http_status()
{
		Http_status_codes=(`cat $Logfile_path | grep -ioE "HTTP\/1\.[1|0]\"[[:blank:]][0-9]{3}" | awk -F'[ ]+' '{
						if($2>=100&&$2<200)
							{i++}
						else if($2>=200&&$2<300)
							{j++}
						else if($2>=300&&$2<400)
							{k++}
						else if($2>=400&&$2<500)
							{n++}
						else if($2>=500)
							{p++}
						}END{
						print i?i:0,j?j:0,k?k:0,n?n:0,p?p:0,i+j+k+n+p
						}'
						`)
		echo -e "\e[1;34mThe number of http status[100+]: \e[1;32m${Http_status_codes[0]}\e[0m"
		echo -e "\e[1;34mThe number of http status[200+]: \e[1;32m${Http_status_codes[1]}\e[0m"
		echo -e "\e[1;34mThe number of http status[300+]: \e[1;32m${Http_status_codes[2]}\e[0m"
		echo -e "\e[1;34mThe number of http status[400+]: \e[1;32m${Http_status_codes[3]}\e[0m"
		echo -e "\e[1;34mThe number of http status[500+]: \e[1;32m${Http_status_codes[4]}\e[0m"
		echo -e "\e[1;34mAll request numbers: \e[1;32m${Http_status_codes[5]}\e[0m"
}

Check_http_code()
{
	Http_Code=(`cat $Logfile_path | grep -ioE "HTTP\/1\.[1|0]\"[[:blank:]][0-9]{3}" | awk -v total=0 -F '[ ]+' '{
					if($2!="")
						{code[$2]++;total++}
					else
						{exit}
					}END{
					print code[404]?code[404]:0,code[403]?code[403]:0,total
					}'`)
	echo -e "\e[1;34mThe number of http status[404]: \e[1;32m${Http_Code[0]}\e[0m"
	echo -e "\e[1;34mThe number of http status[403]: \e[1;32m${Http_Code[1]}\e[0m"
	echo -e "\e[1;34mAll request numbers: \e[1;32m${Http_Code[2]}\e[0m"
}

Check_http_status
Check_http_code
