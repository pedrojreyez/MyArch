# MyArch

> Minimal, monochromatic Arch Linux + Hyprland dotfiles.

A strictly functional, noise-free desktop environment built on Arch Linux and Hyprland. Designed for focus and discipline — every visible element serves a purpose. No decorative noise, no color distractions, no unnecessary animations.


---

## Design Philosophy

| Principle | Application |
|---|---|
| Functional minimalism | Every visible element informs something (time, battery, network, workspace). Nothing purely decorative. |
| Visual quietness | Animations reduced to near-imperceptible ~100ms transitions. No bouncing, no effects. |
| Disciplined monochrome | Grayscale palette. A single desaturated red reserved exclusively for critical states. |
| Typography as hierarchy | Visual differentiation through font weight and size, not color. |
| Cross-app consistency | Kitty, Waybar, Rofi, SwayNC, and Hyprlock share the same palette, border radii, and font. |

---

## Stack

| Category | Tool | Rationale |
|---|---|---|
| Compositor | Hyprland | Dynamic tiling, controllable animations, native IPC |
| Terminal | Kitty | GPU-accelerated, declarative config, no heavy GTK/Qt dependencies |
| Status bar | Waybar | Modular via JSON/CSS, maximum visual control |
| Launcher | Rofi (drun + run) | Largest ecosystem of minimal themes; allows coherent power-menu |
| Notifications | SwayNC | Persistent notification center with history |
| Lock screen | Hyprlock | Native Hyprland configuration, consistent with stack |
| Shell | Zsh + Starship | Declarative TOML prompt, easy to keep minimal without heavy plugins |
| File manager | Nemo | Lightweight GUI with good custom action integration |
| Wallpaper | hyprpaper | Native to Hyprland ecosystem |
| Idle management | hypridle | Official hyprlock companion |
| Screenshots | grim + slurp (hyprshot) | De facto Wayland/Hyprland standard |
| Clipboard | cliphist | Minimal CLI clipboard history |
| Power menu | wlogout | Configurable to text/monochrome icon layout |
| Font | JetBrains Mono Nerd Font | High legibility, glyph support, professional aesthetic |
| System info | fastfetch | Modern neofetch successor, configurable plain text output |

---

## Requirements

- Arch Linux (or Arch-based distro)
- `yay` AUR helper (installed automatically by `install.sh` if missing)
- `git`

---

## Installation

```bash
git clone https://github.com/pedrojreyes/MyArch.git ~/MyArch
cd ~/MyArch
chmod +x install.sh
./install.sh
```

The install script is idempotent — safe to run multiple times. It will:
1. Install all required packages via `pacman` and `yay`
2. Backup any existing configs to `~/.dotfiles_backup/<timestamp>/`
3. Symlink dotfiles using GNU Stow
4. Set Zsh as the default shell

---

## Repository Structure

```
MyArch/
├── README.md
├── LICENSE
├── install.sh
├── docs/
│   └── troubleshooting.md
├── hypr/
│   ├── hyprland.conf
│   ├── conf/
│   │   ├── monitors.conf
│   │   ├── keybindings.conf
│   │   ├── window-rules.conf
│   │   ├── animations.conf
│   │   └── autostart.conf
│   ├── hyprlock.conf
│   ├── hypridle.conf
│   └── hyprpaper.conf
├── waybar/
│   ├── config.jsonc
│   └── style.css
├── rofi/
│   ├── config.rasi
│   └── themes/
│       └── myarch-dark.rasi
├── kitty/
│   └── kitty.conf
├── swaync/
│   ├── config.json
│   └── style.css
├── zsh/
│   ├── .zshrc
│   └── starship.toml
├── wlogout/
│   ├── layout
│   └── style.css
├── fastfetch/
│   └── config.jsonc
├── nemo/
│   └── apply-nemo-settings.sh
└── assets/
    ├── fonts/
    └── wallpapers/
```

---

## Color Palette

Grayscale base with zero color temperature bias. A single exception color reserved exclusively for critical/urgent states.

| Token | Hex | Usage |
|---|---|---|
| `bg-primary` | `#0d0d0d` | Terminal background, lock screen, system base |
| `bg-secondary` | `#161616` | Waybar, Rofi panels, SwayNC |
| `bg-tertiary` | `#1f1f1f` | Hover states, selected elements, notification cards |
| `border` | `#2a2a2a` | Inactive window borders, separators |
| `border-focus` | `#4d4d4d` | Active window border (sole focus differentiator) |
| `fg-primary` | `#e6e6e6` | Primary text |
| `fg-secondary` | `#8a8a8a` | Secondary text, timestamps, inactive icons |
| `fg-muted` | `#5c5c5c` | Placeholders, disabled elements |
| `accent-critical` | `#a33a3a` | Critical battery, urgent notification, system error |

**Golden rule:** if an element is not critical and does not indicate active focus, it renders in grayscale.

---

## Customization

All color values are defined inline using the hex tokens listed above. To change the palette:

1. Perform a global search-and-replace across all config files for the hex values you want to change
2. Ensure the replacement maintains the same contrast ratios for readability
3. The font can be changed by replacing `JetBrains Mono Nerd Font` / `JetBrainsMono Nerd Font` across all files

---

## Roadmap

- [ ] Neovim configuration with matching monochrome theme
- [ ] GTK/Qt theme integration for a fully consistent dark appearance
- [ ] Multi-monitor profile support via `monitors.conf` presets

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

## Credits

Built on top of the work by the [Hyprland](https://hyprland.org/) team and the broader open-source ecosystem powering each tool in this stack.
