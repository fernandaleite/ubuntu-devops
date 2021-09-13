#!/bin/bash

echo -e "\e[92m\n######################################"
echo "###     6. Personalizando GNOME    ###"
echo -e "######################################\e[39m"

echo -e "\e[94m\n-----------------------------Instalando GNOME Tweaks\e[39m"
sudo apt install -y gnome-tweak-tool

echo -e "\e[94m\n-----------------------------Instalando GNOME Shell extensions Chrome integration\e[39m"
sudo apt install chrome-gnome-shell

echo -e "\e[94m\n-----------------------------Instalando extensão do Google Chrome\e[39m"
google-chrome "https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep"  --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'

echo -e "\e[94m\n-----------------------------Instalando dependencias das extensões GNOME\e[39m"
sudo apt install -y gir1.2-gtop-2.0 gir1.2-networkmanager-1.0

echo -e "\e[94m\n-----------------------------Instalando extensões do GNOME\e[39m"
google-chrome "https://extensions.gnome.org/extension/906/sound-output-device-chooser/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/1194/show-desktop-button/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/7/removable-drive-menu/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/779/clipboard-indicator/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/307/dash-to-dock/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/517/caffeine/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/841/freon/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/1112/screenshot-tool/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/28/gtile/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'
google-chrome "https://extensions.gnome.org/extension/904/disconnect-wifi/" --profile-directory="Default"
read -rep $'\e[93m\nAperte <ENTER> para continuar...\e[39m'

