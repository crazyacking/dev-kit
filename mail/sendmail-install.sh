printf "安装mail相关软件和服务"
yum -y install sendmail* > /dev/null 2>&1
yum -y install mailx > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "创建邮件发送配置"
cat > /etc/mail.rc<<EOF
set from=zabbix@xxx.com
set smtp=smtp.xxxx.com
set smtp-auth-user=zabbix@xxx.com
set smtp-auth-password=123456
set smtp-auth=login
EOF
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "设置邮件服务自启动"
systemctl enable sendmail > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "启动邮件服务"
systemctl restart sendmail > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "发送测试邮件"
hostname |mail -s "test" psyduck007@outlook.com
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"