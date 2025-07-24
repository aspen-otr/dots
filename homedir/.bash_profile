export XDG_CONFIG_HOME="${HOME}/.config"

[ -f "~/.bashrc" ] && source ~/.bashrc

if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
    exec river
fi
