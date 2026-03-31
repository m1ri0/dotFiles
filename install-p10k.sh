#!/bin/bash

# Installing p10k theme
echo -e "\e[0;32m Instalando o tema PowerLevel10K... \e[0m"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp .zshrc ~/
cp .p10k.zsh ~/
echo -e "\e[0;32m PowerLevel10K instalado! \e[0m"