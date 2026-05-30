#!/bin/bash

# =============================================================================
# Arch Linux setup script — ardsimm's dotfiles
# =============================================================================

set -e

echo "🚀 Starting installation..."

# =============================================================================
# PACMAN PACKAGES
# =============================================================================
echo "📦 Installing pacman packages..."

sudo pacman -S --needed \
    hyprland \
    xdg-desktop-portal-hyprland \
    intel-media-driver \
    vulkan-intel \
    sddm \
    kitty \
    zsh \
    waybar \
    wofi \
    awww \
    mako \
    libnotify \
    grim \
    slurp \
    cliphist \
    wl-clipboard \
    hyprlock \
    hypridle \
    pipewire \
    pipewire-pulse \
    pipewire-jack \
    wireplumber \
    sof-firmware \
    pavucontrol \
    networkmanager \
    network-manager-applet \
    bluez \
    bluez-utils \
    blueman \
    power-profiles-daemon \
    brightnessctl \
    nwg-look \
    yazi \
    ffmpegthumbnailer \
    jq \
    poppler \
    fd \
    ripgrep \
    fzf \
    zoxide \
    imagemagick \
    p7zip \
    noto-fonts \
    chafa \
    base-devel \
    git \
    neovim \
    vim \
    sudo \
    playerctl \
    lazygit \
    lua51 \
    luarocks \
    zathura \
    zathura-pdf-mupdf \
    wev \
    python-pip \
    noto-fonts-emoji \
    ruby \

echo "📦 Installing yay packages..."

yay -S \
    gruvbox-plus-icon-theme \
    beeper \
  

# =============================================================================
# SERVICES
# =============================================================================
echo "⚙️  Enabling services..."

sudo systemctl enable sddm
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable power-profiles-daemon

# =============================================================================
# YAY (AUR helper)
# =============================================================================
echo "🔧 Installing yay..."

if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# =============================================================================
# AUR PACKAGES
# =============================================================================
echo "📦 Installing AUR packages..."

yay -S --needed \
    ttf-jetbrains-mono-nerd \
    gruvbox-dark-gtk \
    sddm-theme-corners-git \
    zsh-theme-powerlevel10k-git

# =============================================================================
# ZSH PLUGINS (system)
# =============================================================================
echo "🐚 Installing zsh plugins..."

sudo pacman -S --needed \
    zsh-autosuggestions \
    zsh-syntax-highlighting

# =============================================================================
# OH-MY-ZSH
# =============================================================================
echo "🐚 Installing oh-my-zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# =============================================================================
# DEFAULT SHELL
# =============================================================================
echo "🐚 Setting zsh as default shell..."
chsh -s $(which zsh)

# =============================================================================
# SDDM THEME
# =============================================================================
echo "🎨 Configuring SDDM..."

sudo mkdir -p /etc/sddm.conf.d
sudo bash -c 'cat > /etc/sddm.conf << EOF
[Theme]
Current=corners
EOF'

# =============================================================================
# USER SERVICES
# =============================================================================
echo "⚙️  Enabling user services..."

systemctl --user enable pipewire
systemctl --user enable pipewire-pulse
systemctl --user enable wireplumber

# =============================================================================
# PYTHON PACKAGES
# =============================================================================
echo "🐍 Installing Python packages..."

pip install c-formatter-42 --break-system-packages

# =============================================================================
# LUAROCKS PACKAGES
# =============================================================================
echo "🌙 Installing LuaRocks packages..."

luarocks --local --lua-version 5.1 install magick

# =============================================================================
# RUST
# =============================================================================
echo "🦀 Installing Rust..."

if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# =============================================================================
# DIRECTORIES
# =============================================================================
echo "📁 Copying files"

sudo cp -fr ./ ~/.config
cp .zshrc ~

echo ""
echo "✅ Installation complete!"
echo ""
echo "⚠️  Don't forget to:"
echo "   1. Copy your wallpaper to ~/images/wallpapers/gruvbox/dark and ~/images/wallpapers/gruvbox/light"
echo "   2. Run 'p10k configure' after first zsh launch"
echo "   3. Configure SDDM theme at /usr/share/sddm/themes/corners/theme.conf"
echo "   4. Add LuaRocks path to ~/.config/nvim/init.lua"
echo "   5. Launch nvim and run :Lazy sync to install plugins"
echo "   6. Launch nvim and run :Mason to install LSP servers"
echo "   7. Reboot!"
