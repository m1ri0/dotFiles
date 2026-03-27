#!/bin/bash

# error prevention
set -euo pipefail
IFS=$'\n\t'

# updating the system
echo -e "\e[0;32m Iniciando instalação... \e[0m"
echo -e "Atualizando o sistema..."
sudo pacman -Syu -y
echo -e "\e[0;32m [SUCESSO] Sistema atualizado! \e[0m"

# checking dependencies
echo -e "Verificando dependências"
if systemctl is-active --quiet sddm; then
    echo -e "\e[0;32m [SUCESSO] O sddm já está instalado. \e[0m"
else
    echo -e "\e[0;31m [ERRO] O sddm não está instalado. Instalando... \e[0m"
    echo -e "\e[0;31m [ERRO] Instale o sddm antes de continuar. \e[0m"
    exit 1
fi

if [ -d /run/systemd/system ]; then
    echo -e "\e[0;32m [SUCESSO] Systemd está rodando \e[0m"
else
    echo -e "\e[0;31m [ERRO] Systemd não está rodando. Instale o systemd antes de continuar. \e[0m"
    exit 1
fi

# installing AUR Helper (yay)
echo -e "Instalando YAY..."
sudo pacman -S --needed -y base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
sudo rm -rf yay
if command -v yay &> /dev/null; then
    echo -e "\e[0;32m [SUCESSO] YAY instalado! \e[0m"
else
    echo -e "\e[0;31m [ERRO] YAY não foi instalado, ocorreu um erro durante a instalação. \e[0m"
    exit 1
fi

# installing fonts
echo -e "Instalando fontes..."
sudo pacman -S ttf-jetbrains-mono-nerd adwaita-fonts gnu-free-fonts xorg-fonts-encodings
fc-cache -fv

# installing terminal
echo -e "Instalando terminal..."
sudo pacman -S alacritty
mv alacritty ~/.config/alacritty

# installing browser
echo -e "Instalando navegador (zen-browser)..."
yay -S zen-browser-bin

# installing noctalia-shell
echo -e "Instalando Noctalia Shell..."
yay -S noctalia-shell
mv noctalia ~/.config/noctalia-shell

# installing packages from official repositories
echo -e "Instalando pacotes do repositório oficial..."
sudo pacman -S eog zsh

# installing oh-my-zsh and powerlevel10k
echo -e "Instalando oh-my-zsh e powerlevel10k..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
mv .zshrc ~/
mv .p10k.zsh ~/

#ssh keys configs
echo -e "Configurando arquivo de configuração de chaves SSH..."
mv ssh_keys.config ~/.ssh/config
echo -e "\e[0;31m LEMBRE DE COLOCAR AS CHAVES SSH NA PASTA ~/.ssh/ \e[0m"

# Setting dark mode and themes
echo -e "Configurando temas e modo escuro..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
sudo pacman -S papirus-icon-theme adwaita-icon-theme adwaita-icon-theme-legacy hicolor-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
yay -S papirus-folders-git
papirus-folders -l --theme Papirus-Dark
papirus-folders -C teal --theme Papirus-Dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings get org.gnome.desktop.interface color-scheme

bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
echo -e "\e[0;32m Altere o tema do sddm pelo arquivo de configuração \e[0m"
echo -e "Altere o arquivo /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop"
echo -e "Altere a linha ConfigFile=Themes/astronaut.conf"

# Niri configs
echo -e "Configurando Niri.." 
mv niri ~/.config/niri

# rebooting system
echo -e "\e[0;32m Instalação concluída! O sistema será reiniciado para aplicar as mudanças. \e[0m"
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
sudo reboot