#!/usr/bin/env bash
#
# install.sh — Instalador de MyArch
# Idempotente: se puede correr varias veces sin romper nada.
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

info()  { echo -e "\033[1;34m[MyArch]\033[0m $1"; }
ok()    { echo -e "\033[1;32m[OK]\033[0m $1"; }
warn()  { echo -e "\033[1;33m[!]\033[0m $1"; }

# ── 0. Verificación previa ────────────────────────────────
if [[ ! -f /etc/arch-release ]]; then
    warn "Este script está diseñado para Arch Linux. Continúa bajo tu propio riesgo."
fi

# ── 1. Actualizar el sistema ──────────────────────────────
info "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# ── 2. Paquetes oficiales (repos pacman) ──────────────────
info "Instalando paquetes principales..."
sudo pacman -S --needed --noconfirm \
    hyprland xdg-desktop-portal-hyprland \
    qt5-wayland qt6-wayland \
    pipewire pipewire-pulse pipewire-jack wireplumber \
    polkit hyprpolkitagent \
    kitty waybar rofi swaync \
    hyprlock hypridle hyprpaper \
    cliphist wl-clipboard grim slurp \
    zsh starship \
    nemo \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    pavucontrol jq libnotify \
    git base-devel

ok "Paquetes oficiales instalados."

# ── 3. Instalar yay si no existe (para AUR) ───────────────
if ! command -v yay &> /dev/null; then
    info "Instalando yay (AUR helper)..."
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
    (cd "$tmp_dir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmp_dir"
    ok "yay instalado."
else
    ok "yay ya estaba instalado."
fi

# ── 4. Paquetes AUR ────────────────────────────────────────
info "Instalando paquetes desde AUR..."
yay -S --needed --noconfirm wlogout hyprshot
ok "Paquetes AUR instalados."

# ── 5. Symlinks de configuración ──────────────────────────
info "Creando symlinks hacia $REPO_DIR..."
mkdir -p "$HOME_DIR/.dotfiles_backup"

link_config() {
    local name="$1"
    local target="$HOME_DIR/.config/$name"
    if [[ -e "$target" && ! -L "$target" ]]; then
        mv "$target" "$HOME_DIR/.dotfiles_backup/${name}_$(date +%Y%m%d_%H%M%S)"
        warn "Respaldo creado para $name existente."
    fi
    ln -sfn "$REPO_DIR/$name" "$target"
    ok "Symlink: ~/.config/$name -> $REPO_DIR/$name"
}

for module in hypr waybar rofi kitty swaync wlogout fastfetch; do
    link_config "$module"
done

# Zsh y Starship (rutas distintas a .config/<carpeta>)
ln -sfn "$REPO_DIR/zsh/.zshrc" "$HOME_DIR/.zshrc"
ln -sfn "$REPO_DIR/zsh/starship.toml" "$HOME_DIR/.config/starship.toml"
ok "Symlinks de Zsh y Starship creados."

# ── 6. Aplicar configuración de Nemo ──────────────────────
if [[ -f "$REPO_DIR/nemo/apply-nemo-settings.sh" ]]; then
    info "Aplicando configuración de Nemo..."
    bash "$REPO_DIR/nemo/apply-nemo-settings.sh"
    ok "Configuración de Nemo aplicada."
fi

# ── 7. Shell por defecto ──────────────────────────────────
if [[ "$SHELL" != *"zsh"* ]]; then
    info "Cambiando shell por defecto a Zsh..."
    chsh -s "$(which zsh)"
    ok "Shell cambiado a Zsh (aplica en el próximo login)."
else
    ok "Zsh ya es el shell por defecto."
fi

# ── Fin ────────────────────────────────────────────────────
echo ""
ok "¡Instalación de MyArch completa!"
warn "Cierra sesión y selecciona 'Hyprland' en tu gestor de inicio de sesión."
