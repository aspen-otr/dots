.PHONY: help stow eww ayu-gtk

LOCAL_BIN ?= ${HOME}/.local/bin

help:
	@echo "Makefile for Aspen's dotfiles & related builds"
	@echo "Targets:"
	@echo "stow		stow dotfiles to their appropriate places"
	@echo "unstow		unstow dotfiles, effectively removing them until re-stowed"
	@echo "eww		build, if necessary, and then link to LOCAL_BIN (default ~/.local/bin/, currently ${LOCAL_BIN}) the eww executable"

stow:
	stow --dotfiles -t ${HOME} -v stow-tree

unstow:
	stow --dotfiles -t ${HOME} -v -D stow-tree

# Shorthand
eww: ${LOCAL_BIN}/eww

ayu-gtk:
	cd ayu-gtk/ && \
	sed -i 's/\[GNOME_VERSION=.*\]/[GNOME_VERSION="3.22.0"]/' m4/arc-gnome.m4 && \
	./autogen.sh --prefix=/usr && \
	sudo $(MAKE) install

${PWD}/eww-src/target/release/eww:
	cd eww-src && cargo build --quiet --release

${LOCAL_BIN}/eww: ${PWD}/eww-src/target/release/eww
	@mkdir -p $(@D)
	ln -sf $< $@
