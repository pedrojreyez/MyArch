# Solución de Problemas (Troubleshooting)

## 1. Waybar no aparece
- Comprueba si `waybar` está instalado: `pacman -Qs waybar`
- Verifica tu `autostart.conf` dentro de la configuración de Hyprland para confirmar que tiene la línea `exec-once = waybar`.
- Intenta ejecutarlo manualmente desde la terminal escribiendo `waybar` para ver los registros de error.

## 2. Rofi no abre
- Comprueba que estás usando `rofi-wayland` y no la versión para X11 (`rofi`).
- Verifica que la ruta del archivo de configuración esté en `~/.config/rofi/config.rasi`.

## 3. Monitor no detectado
- Usa el comando `hyprctl monitors` para listar las pantallas detectadas.
- Edita el archivo `monitors.conf` con el nombre correcto de tu interfaz (ej. `DP-1`, `eDP-1`, `HDMI-A-1`).

## 4. Nerd Font no carga glifos (íconos rotos)
- Verifica que instalaste el paquete: `pacman -Qs ttf-jetbrains-mono-nerd`.
- Actualiza la caché de fuentes ejecutando: `fc-cache -fv`.
- Reinicia la terminal.

## 5. Cliphist vacío (el portapapeles no guarda historial)
- Verifica que `wl-paste` se está ejecutando en segundo plano en tu archivo `autostart.conf`.
- Asegúrate de tener instalado `wl-clipboard`.

## 6. Hyprlock no aparece
- Verifica que `hyprlock` esté instalado.
- Revisa las rutas de los archivos de configuración de `hypridle` para asegurarte de que están apuntando correctamente a hyprlock.

## 7. Sin sonido o volumen
- Verifica que `wireplumber` esté activo y en ejecución.
- Usa `wpctl status` para ver la lista de dispositivos de audio y comprobar su estado.

## 8. Screenshots no funcionan
- Verifica que tienes los tres paquetes instalados: `grim`, `slurp` y `hyprshot`.
- Asegúrate de que las carpetas de destino existen (generalmente en `~/Pictures/Screenshots`).

## 9. Problemas de permisos con install.sh
- Si el script no se ejecuta, asegúrate de darle permisos de ejecución: `chmod +x install.sh`.

## 10. Conflictos con GNU Stow
- Si Stow lanza un error sobre archivos existentes, haz una copia de seguridad manual de los archivos conflictivos y bórralos.
- Alternativamente, puedes usar `stow --adopt <paquete>` (¡Cuidado: esto sobrescribirá tu repositorio local con la configuración actual del sistema!).
