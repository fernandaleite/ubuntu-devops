#!/bin/bash

echo -e "\e[92m\n##########################################################"
echo "###    1. Instalando aplicacoes de ambiente basicas    ###"
echo -e "##########################################################\e[39m"

echo -e "\e[94m\e[94m\n-----------------------------Criando diretório dos projetos e estudos\e[39m"
mkdir ~/projetos
mkdir ~/estudos

echo -e "\e[94m\n-----------------------------Instalando requisitos para outras instalações\e[39m"

sudo apt install -y coreutils dirmngr gpg jq unzip apt-transport-https ca-certificates software-properties-common make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

echo -e "\e[94m\n-----------------------------Instalando XCLIP\e[39m"
sudo apt install xclip

echo -e "\e[94m\n-----------------------------Instalando Wget\e[39m"
sudo apt install wget

echo -e "\e[94m\n-----------------------------Instalando cURL\e[39m"
sudo apt -y install curl

echo -e "\e[94m\n-----------------------------Instalando HTTPie\e[39m"
sudo apt install -y httpie

echo -e "\e[94m\n-----------------------------Instalando HTOP\e[39m"
sudo apt install -y htop

echo -e "\e[94m\n-----------------------------Instalando CTOP\e[39m"
sudo apt install -y ctop

echo -e "\e[94m\n-----------------------------Configurando SSH\e[39m"

while read -rep $'\e[93m\nQuer configurar uma nova chave SSH? [S/n]: \e[39m' -n 1 GET_VCS && [[ $GET_VCS =~ ^[sS]$ ]]; do
  read -rep $'\e[93mQual o host do gerenciador de repositórios: \e[39m' HOST_NAME
  HOST_NAME=$(echo "$HOST_NAME" | tr '[:upper:]' '[:lower:]')
  REPO_NAME=$(echo $HOST_NAME | tr "." " ")
  REPO_NAME=(${HOST_NAME//./ })
  REPO_NAME=${REPO_NAME[0]}

  echo -e "\e[94m\n-----------------------------Gerando SSH Key para o ${REPO_NAME}:\e[39m"
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_${REPO_NAME}

  echo -e "\e[94m\n-----------------------------Adicionando SSH Key no ${HOST_NAME}:\e[39m"
  xclip -sel clip < ~/.ssh/id_rsa_${REPO_NAME}.pub
  echo -e "\nCopiado para a area de transferencia."

  echo -e "\e[93m\nAguardando configuracao.. Basta ir em Settings > SSH and GPG keys > New SSH Key.\e[39m"
  read -rep $'\e[93mAperte <ENTER> para continuar...\e[39m'

  echo -e "\e[94m\n-----------------------------Configurando SSH Key para o ${REPO_NAME}:\e[39m"

cat <<EOT >> ~/.ssh/config

# Private ${REPO_NAME} instance
Host ${HOST_NAME}
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa_${REPO_NAME}
EOT

  read -rep $'\e[93mPode testar a conectividade? [S/n]: \e[39m' -n 1 SSH_TEST
  SSH_TEST=${SSH_TEST:-S}
  if [[ $SSH_TEST =~ ^[sS]$ ]]; then
    echo -e "\e[94m\n-----------------------------Testando conexao SSH com o ${HOST_NAME}:\e[39m"
	  ssh -T git@${HOST_NAME}
  fi
done

echo -e "\e[94m\n-----------------------------Instalando GIT\e[39m"
sudo apt install -y git

echo -e "\e[94m\n-----------------------------Configurando GIT\e[39m"
read -rep $'\e[93mEntre com o git name: \e[39m' GIT_NAME
read -rep $'\e[93mEntre com o git email: \e[39m' GIT_EMAIL
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL

echo -e "\e[94m\n-----------------------------Instalando AWS CLI\e[39m"
sudo apt install -y awscli

echo -e "\e[94m\n-----------------------------Configurando credenciais AWS\e[39m"
read -rep $'\e[93mConfigurar credenciais agora? [S/n]: \e[39m' -n 1 AWS_CONFIG_NOW
AWS_CONFIG_NOW=${AWS_CONFIG_NOW:-n}
if [[ $AWS_CONFIG_NOW =~ ^[sS]$ ]]; then
    aws configure
fi
