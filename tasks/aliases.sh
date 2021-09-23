#!/bin/bash

echo -e "\e[92m\n######################################"
echo "###     5. Configurando aliases    ###"
echo -e "######################################\e[39m"

cat <<EOT >> ~/.zshrc

# ALIASES

alias zshedit='vim ~/.zshrc'
alias zshclean='source ~/.zshrc'
alias hostsedit='sudo vim /etc/hosts'
alias hostsclean='sudo killall -HUP mDNSResponder; sleep 2;'
alias nginxedit='sudo vim /etc/nginx/nginx.conf'
alias cdnginx='cd /etc/nginx/'
alias show-ports='lsof -i | grep LISTEN'
alias gr='() { grep -r \$1 ~/projetos/ ;}'
alias lsa='ls -la'
alias scan=\"ls | xargs -I % sh -c 'echo %; git -C % status; echo ----------'\"
alias projetos='cd ~/projetos/'
alias estudos='cd ~/estudos/'
alias os-version='cat /etc/os-release'
alias gnome-version='gnome-shell --version'
alias aptsearch='(){ sudo apt search ^\$1$ ;}'
alias open-path='nautilus \$1'
alias restart-terminal='exec "\$SHELL"'
alias net-on='sudo nmcli networking on'
alias net-off='sudo nmcli networking off'
alias net-restart='net-off && net-on'
alias docker-login-stg='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin https://\${AWS_ACCOUNT_ID_PRD}.dkr.ecr.us-east-1.amazonaws.com'
alias docker-login-prd='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin https://\${AWS_ACCOUNT_ID_STG}.dkr.ecr.us-east-1.amazonaws.com'
EOT

