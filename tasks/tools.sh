#!/bin/bash

source $(pwd)/tasks/functions.sh

echo -e "\e[92m\n########################################"
echo "###     4. Instalando Ferramentas    ###"
echo -e "########################################\e[39m"

echo -e "\e[94m\n-----------------------------Instalando Terminator\e[39m"
sudo apt install -y terminator

echo -e "\e[33;1m\nApplying Dracula theme...\e[39m"
echo -e "\e[33;1mCopying config file to ~/.config/terminator\e[39m"
mkdir -p ~/.config/terminator/
touch ~/.config/terminator/config
sudo cp -rf files/config.terminator ~/.config/terminator/config

addToFavorites 'terminator.desktop'

echo -e "\e[94m\n-----------------------------Instalando Postman\e[39m"
sudo snap install postman

addToFavorites 'postman_postman.desktop'

echo -e "\e[94m\n-----------------------------Instalando Sublime\e[39m"
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
sudo apt update
sudo apt install sublime-text

addToFavorites 'sublime_text.desktop'

echo -e "\e[94m\n-----------------------------Instalando Docker\e[39m"
sudo apt install docker
sudo groupadd docker
sudo usermod -aG docker ${USER}

cat <<EOT >> ~/.zshrc

## DOCKER
alias docker-login-stg='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin https://\${AWS_ACCOUNT_ID_PRD}.dkr.ecr.us-east-1.amazonaws.com'
alias docker-login-prd='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin https://\${AWS_ACCOUNT_ID_STG}.dkr.ecr.us-east-1.amazonaws.com'
alias docker-rm-all='docker rm $(docker ps -a -q)'
EOT

echo -e "\e[94m\n-----------------------------Instalando Docker-compose\e[39m"
sudo apt install -y docker-compose

echo -e "\e[94m\n-----------------------------Instalando Redis\e[39m"
sudo apt install -y redis-server

echo -e "\e[94m\n-----------------------------Configurando Redis\e[39m"
sudo sed -i 's,supervised no,supervised systemd,g' /etc/redis/redis.conf
sudo systemctl restart redis.service

echo -e "\e[94m\n-----------------------------Checando Status do Servico Redis\e[39m"
sudo systemctl status redis

echo -e "\e[94m\n-----------------------------Checando Conexao do Redis\e[39m"
redis-cli ping

sleep 3

echo -e "\e[94m\n-----------------------------Instalando SQLite Browser\e[39m"
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser
sudo apt update
sudo apt install sqlitebrowser

echo -e "\e[94m\n-----------------------------Instalando Zoom\e[39m"
sudo snap install zoom-client

echo -e "\e[94m\n-----------------------------Instalando Visual Studio Code\e[39m"
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

addToFavorites 'code.desktop'

echo -e "\e[94m\n-----------------------------Instalando Extensões do Visual Studio Code\e[39m"
code --install-extension shan.code-settings-sync

#  DICAS DE EXTENSÕES
# code --install-extension ahmadalli.vscode-nginx-conf
# code --install-extension dracula-theme.theme-dracula
# code --install-extension esbenp.prettier-vscode
# code --install-extension golang.go
# code --install-extension hashicorp.terraform
# code --install-extension hdg.live-html-previewer
# code --install-extension johnpapa.vscode-peacock
# code --install-extension mikestead.dotenv
# code --install-extension ms-azuretools.vscode-docker
# code --install-extension ms-python.python
# code --install-extension ms-python.vscode-pylance
# code --install-extension ms-toolsai.jupyter
# code --install-extension ms-toolsai.jupyter-keymap
# code --install-extension ms-vscode-remote.remote-containers
# code --install-extension redhat.vscode-yaml
# code --install-extension shakram02.bash-beautify
# code --install-extension Shan.code-settings-sync
# code --install-extension sidthesloth.html5-boilerplate
# code --install-extension vscode-icons-team.vscode-icons
# code --install-extension wingrunr21.vscode-ruby

echo -e "\e[94m\n-----------------------------Instalando JetBrains Toolbox\e[39m"

USER_AGENT='User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'
URL=$(curl 'https://data.services.jetbrains.com//products/releases?code=TBA&latest=true&type=release' -H 'Origin: https://www.jetbrains.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H "${USER_AGENT}" -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: https://www.jetbrains.com/toolbox/download/' -H 'Connection: keep-alive' -H 'DNT: 1' --compressed | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')

wget $URL -O ~/Downloads/jetbrains-toolbox.tar.gz
sudo tar -xzf ~/Downloads/jetbrains-toolbox.tar.gz -C /opt
/opt/jetbrains-toolbox-1.20.8804/jetbrains-toolbox

echo -e "\e[94m\n-----------------------------Instalando Nginx\e[39m"
sudo apt install -y nginx

echo -e "\e[94m\n-----------------------------Configurando Nginx\e[39m"
sudo cp -fr files/nginx.conf /etc/nginx/

cat <<EOT >> ~/.zshrc

## NGINX
alias nginxedit='sudo vim /etc/nginx/nginx.conf'
alias cdnginx='cd /etc/nginx/'
alias nginx-status='sudo systemctl status nginx'
alias nginx-start='sudo systemctl start nginx'
alias nginx-restart='sudo systemctl restart nginx'
alias nginx-stop='sudo systemctl stop nginx'
alias nginx-reload='sudo systemctl reload nginx'
alias nginx-enable='sudo systemctl enable nginx'
EOT

echo -e "\e[94m\n-----------------------------Instalando Slack\e[39m"
sudo snap install slack --classic

addToFavorites 'slack_slack.desktop'

read -rep $'\e[93mDeseja instalar a extensão do Clockwise para o Chrome? [S/n]: \e[39m' -n 1 GET_CLOCK_CRHOME
GET_CLOCK_CRHOME=${GET_CLOCK_CRHOME:-n}
if [[ $GET_CLOCK_CRHOME =~ ^[sS]$ ]]; then
    google-chrome "https://chrome.google.com/webstore/detail/clockwise-time-management/hjcneejoopafkkibfbcaeoldpjjiamog"  --profile-directory="Default"
fi

echo -e "\e[94m\n-----------------------------Instalando VLC\e[39m"
sudo apt install -y vlc

echo -e "\e[94m\n-----------------------------Instalando VPN Client\e[39m"
read -rep $'\e[93mDeseja instalar o OpenVPN Client Pritunl? [S/n]: \e[39m' -n 1 GET_VPN
GET_VPN=${GET_VPN:-n}
if [[ $GET_VPN =~ ^[sS]$ ]]; then
    echo "deb [arch=amd64] https://repo.pritunl.com/stable/apt bionic main" | sudo tee -a /etc/apt/sources.list.d/pritunl.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
    sudo apt update
    sudo apt -y install pritunl-client-electron
    mkdir ~/.openvpn
    read -rep $'\e[93mDeseja criar o arquivo .ovpn? (OpenvnName/vazio) \e[39m' OVPN_NAME
    if [[ ! -z $OVPN_NAME ]]; then
        sudo nano ~/.openvpn/${OVPN_NAME}.ovpn
    fi
    addToFavorites 'pritunl-client-electron.desktop'
else
	echo -e "\nOK! OpenVPN nao sera instalado"
fi

echo -e "\e[94m\n-----------------------------Instalando draw.io Desktop\e[39m"

wget https://github.com/jgraph/drawio-desktop/releases/download/v13.0.3/draw.io-amd64-13.0.3.deb
sudo dpkg -i draw.io-amd64-13.0.3.deb

addToFavorites 'chrome-ilmgmogedobmcfegdjcibiiaodmdenpf-Default.desktop'

echo -e "\e[94m\n-----------------------------Instalando Charles Proxy\e[39m"

wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -

sudo sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'

sudo apt update
sudo apt install charles-proxy

addToFavorites 'charles-proxy.desktop'

echo -e "\e[94m\n-----------------------------Instalando Network Manager OpenVPN\e[39m"

sudo apt update
sudo apt install -y network-manager-openvpn network-manager-openvpn-gnome

cat <<EOT >> ~/.zshrc

## NETWORKING
alias net-on='sudo nmcli networking on'
alias net-off='sudo nmcli networking off'
alias net-restart='net-off && net-on'
EOT

read -rep $'\e[93mDeseja instalar o DBeaver? [S/n]: \e[39m' -n 1 GET_DBEAVER
GET_DBEAVER=${GET_DBEAVER:-n}
if [[ $GET_DBEAVER =~ ^[sS]$ ]]; then
    echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
    wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
    sudo apt update
    sudo apt install dbeaver-ce
fi

read -rep $'\e[93m\nQuer instalar o Postgresql Service? [S/n]: \e[39m' -n 1 PSQL_SURE
PSQL_SURE=${PSQL_SURE:-S}
if [[ $PSQL_SURE =~ ^[sS]$ ]]; then

cat <<EOT >> ~/.zshrc

## POSTGRES
alias postgresql-info='apt show postgresql'
alias postgresql-connect='sudo su - postgres'
alias postgresql-status='sudo systemctl status postgresql'
alias postgresql-stop='sudo systemctl stop postgresql'
alias postgresql-start='sudo systemctl start postgresql'
alias postgresql-disabled='sudo systemctl disable postgresql'
alias postgresql-enable='sudo systemctl enable postgresql'
EOT

    echo -e "\e[94m\n-----------------------------Instalando Postgresql Service\e[39m"
    sudo apt install wget ca-certificates
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ 'lsb_release -cs'-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
    sudo apt update
    sudo apt install postgresql 

    read -rep $'\e[93m\nQuer instalar o pacote "PostgreSQL contrib" (que fornece recursos adicionais)? [S/n]: \e[39m' -n 1 PSQL_CONTR_SURE
    PSQL_CONTR_SURE=${PSQL_CONTR_SURE:-S}
    if [[ $PSQL_CONTR_SURE =~ ^[sS]$ ]]; then
        sudo apt install postgresql-contrib
    fi
fi
