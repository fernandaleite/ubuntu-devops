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
alias list-proc-listen='lsof -i | grep LISTEN'
alias list-proc-with-port='() { lsof -i tcp:\$1 ;}'
alias list-net-with-port='() { netstat -anp tcp | grep \$1 ;}'
alias list-all-conn-port='() { sudo ss -lptn "sport = :\$1" ;}'
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
EOT
