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
    # Hyprland & display
    hyprland \
    xdg-desktop-portal-hyprland \
    mesa \
    intel-media-driver \
    vulkan-intel \
    sddm \
    # Terminal & shell
    kitty \
    zsh \
    # Waybar & launcher
    waybar \
    wofi \
    # Wallpaper
    awww \
    # Notifications
    mako \
    libnotify \
    # Screenshots
    grim \
    slurp \
    # Clipboard
    cliphist \
    wl-clipboard \
    # Lock screen
    hyprlock \
    hypridle \
    # Audio
    pipewire \
    pipewire-pulse \
    pipewire-jack \
    wireplumber \
    sof-firmware \
    pavucontrol \
    # Network
    networkmanager \
    network-manager-applet \
    # Bluetooth
    bluez \
    bluez-utils \
    blueman \
    # Power
    power-profiles-daemon \
    # Brightness
    brightnessctl \
    # GTK theme & appearance
    nwg-look \
    # File manager
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
    # Fonts
    noto-fonts \
    # Terminal image viewer
    chafa \
    # Dev tools
    base-devel \
    git \
    vim \
    sudo

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
# DIRECTORIES
# =============================================================================
echo "📁 Creating directories..."

mkdir -p ~/images/screenshots
mkdir -p ~/images/welcome
mkdir -p ~/images/wallpapers
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/kitty
mkdir -p ~/.config/mako
mkdir -p ~/.config/wofi
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0
mkdir -p ~/.config/zsh
mkdir -p ~/.config/wireplumber/wireplumber.conf.d

echo ""
echo "✅ Installation complete!"
echo ""
echo "⚠️  Don't forget to:"
echo "   1. Copy your dotfiles to ~/.config/"
echo "   2. Copy your wallpaper to ~/images/wallpapers/"
echo "   3. Run 'p10k configure' after first zsh launch"
echo "   4. Configure SDDM theme at /usr/share/sddm/themes/corners/theme.conf"
echo "   5. Reboot!"
