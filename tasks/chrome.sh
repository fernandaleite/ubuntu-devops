#!/bin/bash

echo -e "\e[92m\n##########################################"
echo "###     0. Instalando Google Chrome    ###"
echo -e "##########################################\e[39m"

echo -e "\e[94m\n-----------------------------Instalando Google Chrome\e[39m"
sudo apt install -y google-chrome-stable

read -rep $'\e[93m\nDeseja instalar extensões do Google Chrome? [S/n]: \e[39m' -n 1 CHROME_EXT
CHROME_EXT=${CHROME_EXT:-S}
if [[ $CHROME_EXT =~ ^[sS]$ ]]; then
	echo -e "\e[94m\n-----------------------------Instalando Extensões do Google Chrome\e[39m"
    google-chrome "https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa"  --profile-directory="Default"
    google-chrome "https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb"  --profile-directory="Default"
    # google-chrome "https://chrome.google.com/webstore/detail/toggl-track-productivity/oejgccbfbmkkpaidnkphaiaecficdnfn"  --profile-directory="Default"
    # google-chrome "https://chrome.google.com/webstore/detail/google-keep-chrome-extens/lpcaedmchfhocbbapmcbpinfpgnhiddi"  --profile-directory="Default"
    google-chrome "https://chrome.google.com/webstore/detail/loom-for-chrome/liecbddmkiiihnedobmlmillhodjkdmb"  --profile-directory="Default"
    google-chrome "https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj?hl=pt-br"  --profile-directory="Default"

    read -rep $'\e[93m\nAguardando instalar extensões..\nAperte <ENTER> para continuar...\e[39m'
fi

dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'update-manager.desktop', 'gnome-control-center.desktop',  'gnome-calculator_gnome-calculator.desktop', 'google-chrome.desktop']"
