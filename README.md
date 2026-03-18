# dotFiles 🎨

Configuração pessoal de ambiente de desktop com **Niri** (Wayland Compositor) + **Noctalia Shell** + **SDDM** (Display Manager).

---

## ✅ Pré-requisitos

Antes de iniciar a instalação, certifique-se de que:

1. **Arch Linux** ou derivado instalado
2. **Acesso root/sudo** configurado
3. **systemd-boot** já instalado como bootloader
4. **sddm-greeter** já instalado como greeter do sistema
5. **Conexão com internet** ativa
6. **Git** instalado

---

## 🚀 Instalação Rápida

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/dotFiles ~/dotfiles
cd ~/dotfiles
```

### 2. Dar permissão de execução

```bash
chmod +x install.sh
```

### 3. Executar o script de instalação

```bash
./install.sh
```

> ⚠️ **Nota**: O script será executado de forma interativa. Acompanhe e confirme as instalações.

---

## 📦 O que será instalado

### Build Tools & AUR
- **yay** - Helper do AUR (Arch User Repository)
- **base-devel** - Ferramentas de compilação

### Fontes
- **ttf-jetbrains-mono-nerd** - Fonte monoespacial com ícones Nerd
- **adwaita-fonts** - Fontes Adwaita
- **gnu-free-fonts** - Fontes GNU livres
- **xorg-fonts-encodings** - Encodings de fontes

### Terminal & Shell
- **Alacritty** - Terminal emulator GPU-acelerado
- **Zsh** - Shell interativo
- **Oh My Zsh** - Framework para Zsh
- **Powerlevel10k** - Tema avançado para Zsh

### Desktop & Display
- **Niri** - Compositor Wayland (via yay)
- **Noctalia Shell** - Shell customizado (via yay)
- **SDDM** - Login screen manager
- **EOG** - Eye of GNOME (visualizador de imagens)

### Navegador
- **Zen Browser** - Navegador Firefox baseado

### Ícones & Temas
- **Papirus Icon Theme** - Pack de ícones
- **Adwaita Icon Theme** - Ícones Adwaita
- **Hicolor Icon Theme**

### Utilitários
- **papirus-folders-git** - Customizador de pastas Papirus

---

## 🔧 Configuração Manual

Após o término da instalação, configure manualmente:

### 1. Adicionar Chaves SSH 🔑

```bash
# Criar diretório .ssh se não existir
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copiar suas chaves SSH para ~/.ssh/
# Exemplo:
cp ~/path/to/id_rsa ~/.ssh/
chmod 600 ~/.ssh/id_rsa

# Configurar permissões
chmod 600 ~/.ssh/config
```

### 2. Configurar Powerlevel10k

Na primeira inicialização do Zsh, você será perguntado sobre as configurações do Powerlevel10k. Escolha suas preferências ou:

```bash
p10k configure
```

---

## 🎨 Customização

### Mudar Tema do Alacritty

Edite `~/.config/alacritty/alacritty.toml` e altere a linha de import do tema:

```toml
import = ["~/.config/alacritty/themes/themes/dracula.toml"]
```

### Customizar Niri

Edite `~/.config/niri/config.kdl` para ajustar comportamentos, atalhos e layout.

### Customizar Noctalia

Modifique os arquivos em `~/.config/noctalia/`:
- `settings.json` - Configurações gerais
- `colors.json` - Paleta de cores
- `plugins.json` - Plugins habilitados

---

## 🐛 Troubleshooting

### SDDM não aparece na tela de login

```bash
# Verificar status do SDDM
sudo systemctl status sddm

# Reiniciar SDDM
sudo systemctl restart sddm

# Reabilitar SDDM como display manager padrão
sudo systemctl set-default graphical.target
sudo systemctl enable sddm
```

### Zsh não inicia corretamente

```bash
# Reinstalar Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Reinstalar Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Alacritty não encontra arquivo de tema

Certifique-se de que o path no `alacritty.toml` está correto:

```bash
# Verificar localização dos temas
ls ~/.config/alacritty/themes/themes/
```

### Niri não carrega

```bash
# Verificar erros na configuração
niri check-config

# Verificar logs
journalctl -xe
```

---

## 📝 Notas Importantes

- O script `install.sh` é interativo - acompanhe cada passo
- Backup de configurações existentes é recomendado
- Algumas dependências podem requerer compilação via AUR
- Use `yay` em vez de `pacman` para pacotes do AUR

---

## 🔐 Segurança

- **SSH Keys**: Mantenha suas chaves SSH seguras em `~/.ssh/`
- **SSH Config**: Use `ssh_keys.config` como referência, não como arquivo direto

---

## 📄 Licença

Configuração pessoal - sinta-se livre para adaptar para suas necessidades.

---