#!/bin/bash

function addToFavorites {
    app="$1"
    favoriteApps=$(dconf read /org/gnome/shell/favorite-apps)
    position=${#favoriteApps}-1
    favoriteAppsUpdated="${favoriteApps:0:position}, '${app}'${favoriteApps:position}"
    dconf write /org/gnome/shell/favorite-apps "${favoriteAppsUpdated}"
}

function configASDF {
    if [[ -z $(grep -Fx ". \$HOME/.asdf/asdf.sh" ~/.bashrc) ]]; then
        echo -e "\n. \$HOME/.asdf/asdf.sh" >> ~/.bashrc
    fi
    if [[ -z $(grep -Fx ". \$HOME/.asdf/asdf.sh" ~/.zshrc) ]]; then
        echo -e "\n. \$HOME/.asdf/asdf.sh" >> ~/.zshrc
    fi
    source ~/.bashrc
    sleep 5
}