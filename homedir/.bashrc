#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -a'
alias ll='ls -l'
alias grep=rg
PS1='[\u@\h:\W]\$ '

export PATH="${PATH}:${HOME}/.local/bin"
export GPG_TTY=$(tty)
