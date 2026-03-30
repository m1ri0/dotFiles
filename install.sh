#!/bin/bash

# error prevention
set -euo pipefail
IFS=$'\n\t'

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

# updating the system
echo -e "\e[0;32m Iniciando instalação... \e[0m"
echo -e "Atualizando o sistema e instalando pacotes oficiais..."
sudo pacman -Syu -y openssh ufw zsh ttf-jetbrains-mono-nerd adwaita-fonts gnu-free-fonts xorg-fonts-encodings alacritty eog xorg-xwayland xwayland-satellite papirus-icon-theme adwaita-icon-theme adwaita-icon-theme-legacy hicolor-icon-theme xorg-xeyes gnome-tweaks pipewire pipewire-pulse pipewire-alsa wireplumber pavucontrol btop python3
fc-cache -fv
echo -e "\e[0;32m [SUCESSO] Sistema atualizado! \e[0m"

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

# installing AUR packages
echo -e "Instalando pacotes do AUR..."
yay -S --no-confirm zen-browser-bin papirus-folders-git visual-studio-code-bin cliphist wlsunset xdg-desktop-portal evolution-data-server dracula-gtk-theme-git

#ssh keys configs
echo -e "Configurando arquivo de configuração de chaves SSH..."
if [-d ~/.ssh]; then
    cp ssh_keys.config ~/.ssh/config
else
    mkdir ~/.ssh
    cp ssh_keys.config ~/.ssh/config
fi
echo -e "\e[0;31m LEMBRE DE COLOCAR AS CHAVES SSH NA PASTA ~/.ssh/ \e[0m"

# Setting dark mode
echo -e "Configurando temas e modo escuro..."
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
papirus-folders -C violet --theme Papirus-Dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings get org.gnome.desktop.interface color-scheme

# Setting sddm theme
bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
echo -e "\e[0;32m Altere o tema do sddm pelo arquivo de configuração \e[0m"
echo -e "Altere o arquivo /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop"
echo -e "Altere a linha ConfigFile=Themes/astronaut.conf"

# Configuring
echo "Configurando..."
cp alacritty ~/.config/
cp niri ~/.config/
cp .zshrc ~/
cp .p10k.zsh ~/

# installing noctalia-shell
echo -e "Instalando Noctalia Shell..."
yay -S --no-confirm noctalia-shell
cp noctalia ~/.config/

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
