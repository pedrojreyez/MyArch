#!/usr/bin/env bash
# Menú rápido para cambiar el perfil de energía
current=$(powerprofilesctl get)
choice=$(printf "performance\nbalanced\npower-saver" | rofi -dmenu -p "Perfil de energía (actual: $current)" -theme "$HOME/.config/rofi/themes/myarch-dark.rasi")

if [[ -n "$choice" ]]; then
    powerprofilesctl set "$choice"
    notify-send "Perfil de energía" "Cambiado a: $choice"
fi
