#!/bin/bash

# =============================================================================
# GRUVBOX THEME TOGGLE - dark <-> light
# =============================================================================

STATE_FILE="$HOME/.config/theme/current"
mkdir -p "$HOME/.config/theme"

# Read current state
if [[ -f "$STATE_FILE" ]]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT="dark"
fi

# Determine target
if [[ "$CURRENT" == "dark" ]]; then
    TARGET="light"
else
    TARGET="dark"
fi

echo "Switching to gruvbox-$TARGET..."

# =============================================================================
# COLORS
# =============================================================================
if [[ "$TARGET" == "dark" ]]; then
    GTK_THEME="gruvbox-dark-gtk"
    GTK_DARK_PREF="1"
    HYPR_ACTIVE="d79921ff"
    HYPR_INACTIVE="282828ff"
    WB_BG="rgba(40, 40, 40, 0.85)"
    WB_FG="#ebdbb2"
    WB_MUTED="#a89984"
    WB_YELLOW="#d79921"
    WB_BLUE="#527ecf"
    WB_GREEN="#8ec07c"
    WB_GREEN2="#98971a"
    WB_LIME="#b8bb26"
    WB_RED="#cc241d"
    WB_ORANGE="rgba(214, 93, 14, 0.4)"
    KITTY_THEME="gruvbox_dark.conf"
else
    GTK_THEME="Colloid-Orange-Light-Gruvbox"
    GTK_DARK_PREF="0"
    HYPR_ACTIVE="b57614ff"
    HYPR_INACTIVE="fbf1c7ff"
    WB_BG="rgba(251, 241, 199, 0.85)"
    WB_FG="#3c3836"
    WB_MUTED="#7c6f64"
    WB_YELLOW="#b57614"
    WB_BLUE="#076678"
    WB_GREEN="#427b58"
    WB_GREEN2="#79740e"
    WB_LIME="#79740e"
    WB_RED="#9d0006"
    WB_ORANGE="rgba(175, 58, 3, 0.4)"
    KITTY_THEME="gruvbox_light.conf"
fi

# =============================================================================
# GTK
# =============================================================================
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface color-scheme \
    "$([[ $TARGET == dark ]] && echo 'prefer-dark' || echo 'prefer-light')"

sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME/" \
    "$HOME/.config/gtk-3.0/settings.ini" \
    "$HOME/.config/gtk-4.0/settings.ini"

sed -i "s/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=$GTK_DARK_PREF/" \
    "$HOME/.config/gtk-3.0/settings.ini" \
    "$HOME/.config/gtk-4.0/settings.ini"

# =============================================================================
# HYPRLAND
# =============================================================================
sed -i \
    "s/col\.active_border = rgba([0-9a-fA-F]*)/col.active_border = rgba($HYPR_ACTIVE)/" \
    "$HOME/.config/hypr/hyprland.conf"

sed -i \
    "s/col\.inactive_border = rgba([0-9a-fA-F]*)/col.inactive_border = rgba($HYPR_INACTIVE)/" \
    "$HOME/.config/hypr/hyprland.conf"

hyprctl reload

# =============================================================================
# KITTY
# =============================================================================
sed -i "s/^include .*/include $KITTY_THEME/" "$HOME/.config/kitty/kitty.conf"

# Signal all running kitty instances to reload their config
kill -SIGUSR1 $(pidof kitty) 2>/dev/null

# =============================================================================
# WAYBAR
# =============================================================================
WB_CSS="$HOME/.config/waybar/style.css"

sed -i "s/background: rgba([^)]*)/background: $WB_BG/g" "$WB_CSS"
sed -i "/#clock/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_FG/" "$WB_CSS"
sed -i "/#workspaces button {/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_MUTED/" "$WB_CSS"
sed -i "/#workspaces button.active/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_FG/" "$WB_CSS"
sed -i "/#workspaces button.active/,/}/ s/background: rgba([^)]*)/background: $WB_ORANGE/" "$WB_CSS"
sed -i "/#pulseaudio/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_YELLOW/" "$WB_CSS"
sed -i "/#bluetooth/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_BLUE/" "$WB_CSS"
sed -i "/#network/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_GREEN/" "$WB_CSS"
sed -i "/#battery/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_LIME/" "$WB_CSS"
sed -i "/#custom-mic {/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_GREEN2/" "$WB_CSS"
sed -i "/#custom-mic.muted/,/}/ s/color: #[0-9a-fA-F]*/color: $WB_RED/" "$WB_CSS"

pkill -SIGUSR2 waybar

# =============================================================================
# NEOVIM - write flag + signal live instances
# =============================================================================
echo "$TARGET" > "$HOME/.config/theme/current"
pkill -SIGUSR1 nvim 2>/dev/null

# =============================================================================
# WOFI
# =============================================================================
WOFI_CSS="$HOME/.config/wofi/style.css"

if [[ "$TARGET" == "dark" ]]; then
    WOFI_BG="rgba(40, 40, 40, 0.85)"
    WOFI_FG="#ebdbb2"
    WOFI_ACCENT="#d79921"
    WOFI_SELECTED="rgba(215, 153, 33, 0.3)"
else
    WOFI_BG="rgba(251, 241, 199, 0.85)"
    WOFI_FG="#3c3836"
    WOFI_ACCENT="#b57614"
    WOFI_SELECTED="rgba(181, 118, 20, 0.3)"
fi

sed -i "s/background-color: rgba([^)]*)/background-color: $WOFI_BG/g" "$WOFI_CSS"
sed -i "/^window/,/}/ s/border: 2px solid #[0-9a-fA-F]*/border: 2px solid $WOFI_ACCENT/" "$WOFI_CSS"
sed -i "/#input/,/}/ s/color: #[0-9a-fA-F]*/color: $WOFI_FG/" "$WOFI_CSS"
sed -i "/#input/,/}/ s/border-bottom: 2px solid #[0-9a-fA-F]*/border-bottom: 2px solid $WOFI_ACCENT/" "$WOFI_CSS"
sed -i "/#entry:selected/,/}/ s/background-color: rgba([^)]*)/background-color: $WOFI_SELECTED/" "$WOFI_CSS"
sed -i "/#text/,/}/ s/color: #[0-9a-fA-F]*/color: $WOFI_FG/" "$WOFI_CSS"

# =============================================================================
# MAKO
# =============================================================================
MAKO_CONF="$HOME/.config/mako/config"

if [[ "$TARGET" == "dark" ]]; then
    MAKO_BG="#28282888"
    MAKO_FG="#ebdbb2"
    MAKO_BORDER="#d79921"
else
    MAKO_BG="#fbf1c788"
    MAKO_FG="#3c3836"
    MAKO_BORDER="#b57614"
fi

sed -i "s/^background-color=.*/background-color=$MAKO_BG/" "$MAKO_CONF"
sed -i "s/^text-color=.*/text-color=$MAKO_FG/" "$MAKO_CONF"
sed -i "s/^border-color=.*/border-color=$MAKO_BORDER/" "$MAKO_CONF"

makoctl reload

# =============================================================================
# XSETTINGSD (X11 apps theme)
# =============================================================================
XSETTINGS_CONF="$HOME/.config/xsettingsd/xsettingsd.conf"

sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"$GTK_THEME\"/" "$XSETTINGS_CONF"

pkill -HUP xsettingsd 2>/dev/null

# =============================================================================
# BTOP
# =============================================================================
BTOP_CONF="$HOME/.config/btop/btop.conf"

if [[ "$TARGET" == "dark" ]]; then
    BTOP_THEME="gruvbox_dark"
else
    BTOP_THEME="gruvbox_light"
fi

sed -i "s/^color_theme = .*/color_theme = \"$BTOP_THEME\"/" "$BTOP_CONF"

# =============================================================================
# WALLPAPER_DIR
# =============================================================================

if [[ "$TARGET" == "light" ]]; then
    WALLPAPER_DIR="$HOME/images/wallpapers/gruvbox/light"
else
    WALLPAPER_DIR="$HOME/images/wallpapers/gruvbox/dark"
fi

# =============================================================================
# SLIDESHOW - restart with new wallpaper dir
# =============================================================================
pkill -f "slide_show.sh"
bash ~/.config/theme/slide_show.sh "$WALLPAPER_DIR" 1 &

# =============================================================================
# STATE
# =============================================================================
echo "$TARGET" > "$STATE_FILE"
notify-send "Theme" "Switched to gruvbox-$TARGET" --icon=preferences-desktop-theme

echo "Done. Now on gruvbox-$TARGET."
