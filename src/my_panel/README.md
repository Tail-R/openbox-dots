# About The Project
This is my simple Gtk4 panel app written in Vala :3

# Dependencies
- vala
- gtk4
- meson

## For the scripts
- nmcli
- pamixer
- playerctl

```bash
sudo pacman -S vala gtk4 meson
```

# Usage
Don't forget to make the scripts executable :3

```bash
meson setup build
meson compile -C build

./build/my_panel
```

