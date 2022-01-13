#!/bin/bash

source $(pwd)/tasks/functions.sh

echo -e "\e[92m\n##############################################"
echo "###     3. Instalando Aplicacoes de Dev    ###"
echo -e "##############################################\e[39m"

echo -e "\e[94m\n-----------------------------Instalando ASDF\e[39m"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

while : ; do
    configASDF
    echo -e "\e[93m\nVerificando instalação do ASDF:\e[39m asdf version"
    ASDF_VERSION=$(asdf version 2>&1) 
    if ! [[ $ASDF_VERSION == *"comando não encontrado"* || $ASDF_VERSION == *"command not found"* ]]; then break fi
    
    read -rep $'\e[93mTentar novamente? [S/n] \e[39m' TRY_AGAIN
    TRY_AGAIN=${TRY_AGAIN:-S} 
    if [[ $TRY_AGAIN =~ ^[nN]$ ]]; then
        echo "[ASDF] An error occurred. Exiting..." >&2
        exit 1
    fi
done

echo "legacy_version_file = yes" > ~/.asdfrc

echo -e "\e[94m\n-----------------------------Instalando Go Lang\e[39m"

asdf plugin-add golang
asdf install golang latest
asdf global golang $(ls /$HOME/.asdf/installs/golang)

echo -e "\e[94m\n-----------------------------Configurando Go Lang\e[39m"
mkdir -p ~/gocode
mkdir -p ~/gocode/bin
mkdir -p ~/gocode/pkg
mkdir -p ~/gocode/src

cat <<EOT >> ~/.zshrc

## GOLANG
GOV=\$(asdf where golang)
export GOROOT=\$GOV/go
export GOPATH=\$HOME/gocode
export PATH="\$GOPATH/bin:\$PATH"
export GO111MODULE="on"
EOT

echo -e "\e[94m\n-----------------------------Instalando Java\e[39m"

asdf plugin-add java
asdf install java latest
asdf global java $(ls /$HOME/.asdf/installs/java)

# comentado instruções para instalação de várias versões no setup inicial

# asdf list-all java

# while read -rep $'\e[93m\nQual versao de Java deseja instalar. [openjdk-16.0.1/vazio]: \e[39m' JDK_VERSION && [[ ! -z $JDK_VERSION ]]; do
#     asdf install java $JDK_VERSION
# done

# JDK_VERSIONS=($(ls /$HOME/.asdf/installs/java))

# if [ ${#JDK_VERSIONS[@]} == 1 ]; then
#     asdf global java $(ls /$HOME/.asdf/installs/java)
# else
#     asdf list java
#     read -rep $'\e[93mQual versao de Java deseja que seja a GLOBAL. e.g.(openjdk-16.0.1): \e[39m' JDK_GLOBAL
#     JDK_GLOBAL=${JDK_GLOBAL:-openjdk-16.0.1}
#     asdf global java ${JDK_GLOBAL}
# fi

## Configurando o JAVA_HOME

. ~/.asdf/plugins/java/set-java-home.zsh

java -version

echo -e "\e[94m\n-----------------------------Instalando Node JS\e[39m"

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install nodejs latest
asdf global nodejs $(ls /$HOME/.asdf/installs/nodejs)

node -v
npm -v

echo -e "\e[94m\n-----------------------------Instalando Maven\e[39m"

asdf plugin-add maven
asdf install maven latest
asdf global maven $(ls /$HOME/.asdf/installs/maven)

cat <<EOT >> ~/.zshrc

## MAVEN
export M2_HOME=\$(asdf where maven)
export PATH="\$M2_HOME/bin:\$PATH"
EOT

echo -e "\e[94m\n-----------------------------Instalando Yarn JS\e[39m"

asdf plugin-add yarn
asdf install yarn latest
asdf global yarn $(ls /$HOME/.asdf/installs/yarn)

echo -e "\e[94m\n-----------------------------Instalando Terraform\e[39m"

asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git
asdf install terraform latest
asdf global terraform $(ls /$HOME/.asdf/installs/terraform)

echo -e "\e[94m\n-----------------------------Instalando Python\e[39m"

touch .default-python-packages
asdf plugin-add python
asdf install python latest
asdf global python $(ls /$HOME/.asdf/installs/python)

# comentado instruções para instalação de várias versões no setup inicial

# asdf list-all python

# while read -rep $'\e[93m\nQual versao de Python deseja instalar. [3.9.6/vazio]: \e[39m' PY_VERSION && [[ ! -z $PY_VERSION ]]; do
#     asdf install python $PY_VERSION
# done

# PY_VERSIONS=($(ls /$HOME/.asdf/installs/python))

# if [ ${#PY_VERSIONS[@]} == 1 ]; then
#     asdf global python $(ls /$HOME/.asdf/installs/python)
# else 
#     asdf list python
#     read -rep $'\e[93mQual versao de Python deseja que seja a GLOBAL. e.g.(3.9.6): \e[39m' PY_GLOBAL
#     PY_GLOBAL=${PY_GLOBAL:-3.9.6}
#     asdf global python ${PY_GLOBAL}
# fi

python --version

echo -e "\e[94m\n-----------------------------Instalando PHP\e[39m"

sudo apt install -y autoconf bison re2c libxml2-dev libcurl libgd-dev libonig-dev libzip-dev
asdf plugin-add php https://github.com/asdf-community/asdf-php.git
asdf install php latest
asdf global php $(ls /$HOME/.asdf/installs/php)

php --version

echo -e "\e[94m\n-----------------------------Finalizado Configurações do ASDF\e[39m"
echo -e "-----------------------------Plugins adicionados:"
asdf current

echo -e "\e[94m\n-----------------------------Instalando Serverless\e[39m"
curl -o- -L https://slss.io/install | bash

cat <<EOT >> ~/.zshrc

## SERVERLESS
export PATH="\$HOME/.serverless/bin:\$PATH"
EOT

# echo -e "\e[94m\n-----------------------------Instalando Protobuf Compiler\e[39m"
# sudo apt install -y protobuf-compiler
# protoc --version  # Ensure compiler version is 3+

echo -e "\e[94m\n-----------------------------Instalando Kubectl\e[39m"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl --version

cat <<EOT >> ~/.zshrc

## KUBECTL
export PATH="/usr/local/bin/kubectl:\$PATH"
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
EOT

echo -e "\e[94m\n-----------------------------Instalando Kubeval\e[39m"
wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
sudo mv kubeval /usr/local/bin
rm -f kubeval-linux-amd64.tar.gz
kubeval --version

# Poetry para gerenciamento de dependências de Python e virtualenvs
echo -e "\e[94m\n-----------------------------Instalando Poetry\e[39m"

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

cat <<EOT >> ~/.zshrc

## POETRY
export POETRY_HOME="\$HOME/poetry/bin"
export PATH="\$POETRY_HOME:\$PATH"
alias poetry-envs-list='ls ~/.cache/pypoetry/virtualenvs/'
alias poetry-envs-edit='cd ~/.cache/pypoetry/virtualenvs/'
EOT

poetry --version

## fica em $HOME/. config/Code/User/settings. json
echo -e "\n\nAdicionar no settings do seu VSCODE :: `"python.venvFolders": ["~/.cache/pypoetry/virtualenvs/"]`\n\n"

# Oh-My-Zsh
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# For oh-my-zsh, you must then enable poetry in your ~/.zshrc plugins
sed -i 's,zsh-completions),zsh-completions poetry),g' ~/.zshrc
