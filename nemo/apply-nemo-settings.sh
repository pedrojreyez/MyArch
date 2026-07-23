#!/usr/bin/env bash
# Aplica configuración de Nemo coherente con la estética MyArch

# Vista por defecto: lista (más profesional que iconos)
gsettings set org.nemo.preferences default-folder-viewer 'list-view'

# Mostrar archivos ocultos por defecto
gsettings set org.nemo.preferences show-hidden-files true

# Fuente monospace
gsettings set org.nemo.desktop font 'JetBrains Mono Nerd Font 11'

# Ordenar por nombre
gsettings set org.nemo.preferences default-sort-order 'name'

# Tema oscuro preferido (GTK)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# Desactivar preview de archivos grandes
gsettings set org.nemo.preferences show-image-thumbnails 'local-only'

echo "Configuración de Nemo aplicada."
