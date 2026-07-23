#!/usr/bin/env bash
set -euo pipefail

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[EXITO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[ADVERTENCIA]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

PACMAN_PKGS=(
    git stow zsh hyprland hyprpaper hypridle hyprlock kitty waybar 
    swaync wlogout grim slurp fastfetch nemo brightnessctl playerctl 
    wl-clipboard cliphist polkit-kde-agent ttf-jetbrains-mono-nerd starship
)

# En Arch, rofi-wayland está extra/community a veces, o en AUR.
AUR_PKGS=(
    rofi-wayland hyprshot
)

# 1. Comprobar si es Arch Linux
if [ ! -f /etc/arch-release ]; then
    log_error "Este script está diseñado para Arch Linux."
    exit 1
fi
log_info "Sistema Arch Linux detectado."

# 2. Instalar paquetes de pacman
log_info "Instalando paquetes de pacman..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# 3. Comprobar/Instalar yay (AUR helper)
if ! command -v yay &> /dev/null; then
    log_warn "yay no encontrado. Instalando yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR"
    rm -rf /tmp/yay
fi

# 4. Instalar paquetes de AUR
log_info "Instalando paquetes de AUR..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# 5 & 6. Stow de paquetes
mkdir -p "$BACKUP_DIR"
STOW_PKGS=(hypr waybar rofi kitty swaync wlogout fastfetch)

log_info "Aplicando configuraciones con Stow..."
for pkg in "${STOW_PKGS[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        stow -R -t "$HOME/.config" "$pkg" || log_warn "Problema aplicando stow para $pkg"
    fi
done

# 7. Configuración de zsh
log_info "Configurando zsh y starship..."
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi
if [ -f "$DOTFILES_DIR/zsh/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    ln -sf "$DOTFILES_DIR/zsh/starship.toml" "$HOME/.config/starship.toml"
fi

# 8. Nemo settings
if [ -f "$DOTFILES_DIR/nemo/apply-nemo-settings.sh" ]; then
    log_info "Aplicando configuración de Nemo..."
    bash "$DOTFILES_DIR/nemo/apply-nemo-settings.sh"
fi

# 9. Wallpaper
if [ -d "$DOTFILES_DIR/assets" ]; then
    log_info "Configurando assets (fondos, etc.)..."
    mkdir -p "$HOME/.config/hypr/assets"
    cp -r "$DOTFILES_DIR/assets/"* "$HOME/.config/hypr/assets/" || true
fi

# 10. Cambiar shell a zsh
if [[ "$SHELL" != */zsh ]]; then
    log_info "Cambiando shell por defecto a zsh..."
    chsh -s "$(which zsh)"
fi

log_success "Instalación completada con éxito. Por favor, cierra sesión y vuelve a entrar."
