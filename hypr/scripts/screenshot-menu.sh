#!/usr/bin/env bash
# Menú rápido de captura de pantalla
choice=$(printf "Pantalla completa\nRegión\nVentana" | rofi -dmenu -p "Captura" -theme "$HOME/.config/rofi/themes/myarch-dark.rasi")

case "$choice" in
    "Pantalla completa") hyprshot -m output ;;
    "Región") hyprshot -m region ;;
    "Ventana") hyprshot -m window ;;
esac
