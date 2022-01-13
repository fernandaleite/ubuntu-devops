# ubuntu-devops

Este projeto foi criado com o intuito de facilitar a configuração de um ambiente de desenvolvimento que possa ser utilizado tanto para fins educativos quanto profissionais. Ele foi preparado para kernel Linux sob o sistema operacional Ubuntu 18.04.5 LTS. 

A motivação para publicação do mesmo veio do outro criado para macos()

Entre atualizações, instalações e configurações, o script demora cerca de x minutos para ser finalizado. 

Como possui algumas interações sobre decisões, é melhor ficar observando enquanto o mesmo é executado.

## Como executar

Para rodar execute no terminal:

1. `sudo chmod +x starter.sh`

2. `./starter.sh`

## O que contem no script

Nos script contem a instalação das seguintes ferramentas:

### basic

* XCLIP
* CURL
* WGET
* HTTPie
* HTOP
* CTOP
* SSH
* GIT
* AWS CLI

### oh-my-zsh

* Instalação do Oh My Zsh
* Plugin Syntax Highlighting
* Plugin Autosuggestions
* Plugin completions
* Buscador Fuzzy Finder
* Tema SpaceShip
* Fonte FiraCode
* Cores Dracula

### development

* ASDF
* Go Lang
* Java
* Maven
* Node JS
* Yarn JS
* Terraform
* Python
* Poetry
* Serverless
* Kubectl
* Kubeval
* PHP

### tools

* Terminator
* Postman
* Sublime
* Docker
* Docker-compose
* Redis
* Zoom
* Google Chrome
* Visual Studio Code
* JetBrains Toolbox
* Nginx
* Slack
* VLC
* OpenVPN Client
* DBeaver
* Charles

### gnome

* Extensão do Chrome
* Extensões do Gnome

### Detalhes pessoais:

#### Criar próprio usuário caso não tenha vindo:

sudo adduser --force-badname fernanda.leite && sudo usermod -aG sudo fernanda.leite

#### Configuração Teclado Logitech K850:

Configurações > Região e Idioma > Fontes de entrada (+) > Inglês (Estados Unidos) > Inglês (EUA, intern. alt.)

#### Plugins Slack

* Clockwise

#### Impressora e Scanner

apt search hplip

* Ps: não sei qual deles conseguiu fazer o que, então tem q testar de novo com calma da proxima
