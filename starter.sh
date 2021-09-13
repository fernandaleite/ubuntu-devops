#!/bin/bash

echo -e "\e[92m\n\n###########################################"
echo "###     INICIANDO CONFIG PARA UBUNTU    ###"
echo -e "###########################################\n\e[39m"

echo -e "\e[92mUpdate..\e[39m"
sudo apt -y update
echo -e "\e[92m\nUpgrade..\e[39m"
sudo apt -y upgrade

echo -e "\e[94m\n-----------------------------Iniciando instalaçoes\e[39m"
echo -e "\e[94m-----------------------------Ajustando permissoes de scripts\e[39m"
sudo chmod -R +x tasks/

echo -e "\e[92m\n\n################################"
echo "###     Aplicando scripts    ###"
echo -e "################################\e[39m"
./tasks/chrome.sh
./tasks/basic.sh
./tasks/oh-my-zsh.sh
./tasks/development.sh
./tasks/tools.sh
./tasks/aliases.sh
./tasks/gnome.sh

echo -e "\e[92m\n##########################"
echo "###     Finalizando    ###"
echo -e "##########################\n\e[39m"

echo -e "\e[92mAutoremove..\e[39m"
sudo apt autoremove

echo -e "\nO sistema precisa ser reiniciado..."
read -rep $'\e[93m\nReiniciar maquina agora? [S/n]: \e[39m' -n 1 SURE
SURE=${SURE:-S}
if [[ $SURE =~ ^[sS]$ ]]; then
	echo -e "\nReiniciando...................\n"
	sleep 5 && shutdown -r now
	
else
	echo -e "\nSuave na nave.. ;)\n"
fi
