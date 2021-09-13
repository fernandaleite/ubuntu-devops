#!/bin/bash

echo -e "\e[92m\n###########################"
echo "###     2. Oh My Zsh    ###"
echo -e "###########################\e[39m"

echo -e "\e[94m\n-----------------------------Instalando shell Zsh\e[39m"
sudo apt install -y zsh

echo -e "\e[94m\n-----------------------------Instalando Oh My Zsh\e[39m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\e[94m\n\n-----------------------------Instalando padrão de cores Dracula\e[39m"
sudo apt install dconf-cli
git clone https://github.com/dracula/gnome-terminal.git ~/gnome-terminal

printf "1\n1\nyes\n2\n" | bash ~/gnome-terminal/install.sh

echo -e "\e[94m\n\n-----------------------------Instalando plugin Syntax Highlighting\e[39m"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "\e[94m\n\n-----------------------------Instalando plugin Autosuggestions\e[39m"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "\e[94m\n\n-----------------------------Instalando plugin Completions\e[39m"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo -e "\e[94m\n\n-----------------------------Configurando os plugins no ZSHRC\e[39m"
sed -i 's,plugins=(git),plugins=(git git-flow asdf httpie node npm golang vscode yarn docker docker-compose aws github gitignore zsh-syntax-highlighting zsh-autosuggestions zsh-completions),g' ~/.zshrc

autoload -U compinit && compinit
rm -f ~/.zcompdump; compinit

echo -e "\e[94m\n\n-----------------------------Instalando buscador Fuzzy Finder\e[39m"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo -e "\e[94m\n\n-----------------------------Instalando fonte FiraCode\e[39m"
sudo apt install fonts-firacode

### Troubleshooting FiraCode
#git clone https://github.com/tonsky/FiraCode.git ~/tmp
#sudo mv -i /tmp/FiraCode/distr/ttf /usr/share/fonts/truetype/fira-code
#sudo fc-cache -fv

echo -e "\e[94m\n\n-----------------------------Instalando tema SpaceShip\e[39m"
git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt

echo -e "\e[94m\n\n-----------------------------Criando link simbolico para o arquivo do tema do Spaceship na pasta dos temas do Oh My Zsh\e[39m"
ln -s "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"

echo -e "\e[94m\n\n-----------------------------Configurando o tema no ZSHRC\e[39m"
sed -i 's,ZSH_THEME="robbyrussell",ZSH_THEME="spaceship",g' ~/.zshrc

cat <<EOT >> ~/.zshrc

# Adjusts theme SpaceShip
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
EOT

