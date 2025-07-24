export XDG_CONFIG_HOME="${HOME}/.config"
export HOSTNAME="$(cat /etc/hostname)"
export PATH="${PATH}:${HOME}/.local/bin"

[ -f "~/.bashrc" ] && source ~/.bashrc

if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
    exec river
fi
