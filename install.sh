#!/bin/bash

# installing AUR Helper (yay)
sudo pacman -S --needed --no-confirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
sudo rm -rf yay

# installing fonts
sudo pacman -S ttf-jetbrains-mono-nerd adwaita-fonts gnu-free-fonts xorg-fonts-encodings
fc-cache -fv

# installing terminal
sudo pacman -S --no-confirm alacritty
mv alacritty ~/.config/alacritty

# installing browser
yay -S --no-confirm zen-browser-bin

# installing noctalia-shell
yay -S --no-confirm noctalia-shell
mv noctalia ~/.config/noctalia-shell

# installing packages from official repositories
sudo pacman -S --no-confirm eog sddm zsh

# installing oh-my-zsh and powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
mv .zshrc ~/
mv .p10k.zsh ~/

#ssh keys configs
mv ssh_keys.config ~/.ssh/config
echo -e "\e[0;31m LEMBRE DE COLOCAR AS CHAVES SSH NA PASTA ~/.ssh/ \e[0m"

# Setting dark mode and themes
sudo pacman -S --no-confirm papirus-icon-theme adwaita-icon-theme adwaita-icon-theme-legacy hicolor-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
yay -S --no-confirm papirus-folders-git
papirus-folders -l --theme Papirus-Dark
papirus-folders -C teal --theme Papirus-Dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings get org.gnome.desktop.interface color-scheme

# switching to sddm
rm /etc/systemd/system/display-manager.service
ln -s /usr/lib/systemd/system/sddm.service /etc/systemd/system/display-manager.service
sudo pacman -Rns lightdm lightdm-gtk-greeter
bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
echo -e "\e[0;32m Altere o tema do sddm pelo arquivo de configuração \e[0m"

# Niri configs
mv niri ~/.config/niri

# rebooting system
echo -e "\e[0;32m Instalação concluída! O sistema será reiniciado para aplicar as mudanças. \e[0m"
sudo reboot