# dotFiles 🎨

Configuração pessoal para ambiente desktop no Arch Linux utilizando **Niri** (Wayland), **Noctalia Shell**, **Alacritty** e **Zsh**.

Este repositório contém scripts de automatização (`.sh`) para instalar dependências, configurar o ambiente gráfico e preparar o terminal.

---

## ✅ Pré-requisitos

Para que o script fundamental (`install.sh`) funcione, você deve ter:

1. **Arch Linux** (ou sistema base Arch) operando.
2. Usuário com privilégios de **sudo** configurados.
3. Demon do **systemd** como init system.
4. **SDDM** instalado e *ativo* (o script abortará se o sddm não estiver em execução).
5. Conexão com a Internet.
6. **Git** pré-instalado.

---

## 🚀 Como Instalar

A instalação foi dividida em três etapas. 

### 1. Preparação

Clone o repositório e dê permissão de execução em todos os scripts:

```bash
git clone https://github.com/seu-usuario/dotFiles ~/dotFiles
cd ~/dotFiles
chmod +x install.sh install-ohmyzsh.sh install-p10k.sh
```

### 2. Instalação Base (Pacotes e Configuração de Ambiente)

Este é o instalador principal. Ele instalará pacotes via `pacman`, compilará o `yay`, puxará dependências do AUR, aplicará o tema do SDDM, e copiará as configurações (`alacritty`, `niri`, `noctalia`). 

Ao final, ele fará um **reboot automático**.

```bash
./install.sh
```

### 3. Configuração do Terminal (Zsh + P10k)

Após o reboot, volte à pasta e instale o framework do Zsh e o tema:

```bash
cd ~/dotFiles

# Instala o Oh My Zsh e muda seu shell padrão para zsh (Confirme com Y)
./install-ohmyzsh.sh

# Instala o Powerlevel10k e plugins adicionais
./install-p10k.sh
```

---

## 📦 Detalhes do que cada script faz

### `install.sh`
Executa as seguintes etapas nesta ordem estrita:

1. **Validação**: Verifica se o `sddm` e `systemd` então ativos.
2. **Pacotes Oficiais**: Instala/atualiza utilitários do sistema, fontes Nerd/Adwaita, ambiente Xwayland, Alacritty, temas de ícones (Papirus), utilitários de áudio (Pipewire) e outras ferramentas.
3. **Cache de Fontes**: Atualiza cache usando `fc-cache`.
4. **AUR Helper**: Compila e instala nativamente a base-devel e o `yay`.
5. **Pacotes AUR**: Instala navegadores (Zen Browser), VS Code, temas e dependências gráficas complementares do Wayland.
6. **Configuração SSH**: Move o arquivo base `ssh_keys.config` para as configurações do usuário em `~/.ssh/config`.
7. **Temas (GTK/Folders)**: Aplica o modo escuro no GNOME Desktop Interface e pinta as pastas do Papirus.
8. **Tema SDDM**: Baixa e instala o tema Astronaut via script externo.
9. **Dotfiles**: Move pastas do `alacritty` e `niri` configuradas para `~/.config/`.
10. **Instalação do Noctalia**: Baixa o Shell e copia as configurações customizadas contidas na pasta `noctalia`.
11. **Finalização**: Reinicia a máquina em contagem regressiva.

### `install-ohmyzsh.sh`
- Apenas engatilha a instalação padrão e remota do Oh My Zsh.
- Exige interação do usuário para mudar o shell padrão do sistema.

### `install-p10k.sh`
- Clona o tema **Powerlevel10k** no diretório do Oh My Zsh.
- Clona utilitários essenciais (**zsh-autosuggestions** e **zsh-syntax-highlighting**).
- Aloca a sua configuração customizada do zsh (`.zshrc`) para a home.
- Aloca a sua configuração customizada do p10k (`.p10k,zsh`) para a home.

---

## 🔧 Configuração Manual Restante

Após a execução, algumas tarefas de segurança e tema necessitam revisão manual:

1. **Chaves SSH**  
   Você deve colar as suas chaves privadas dentro da pasta `~/.ssh/` e reajustar permissões.
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/config
   chmod 600 ~/.ssh/sua_chave_privada
   ```

2. **Tema Default no SDDM**  
   Abra`/usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop` e assegure-se de que a linha aponta para a conf correta:
   `ConfigFile=Themes/astronaut.conf`

3. **Configuração Zsh Visual**  
   Reconfigure ou gere sua fonte caso queira alterar a versão default fornecida nos `.dotfiles`:
   ```bash
   p10k configure
   ```