#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -a'
alias ll='ls -l'
alias grep=rg

PS1_EXIT_STATUS_() { local EC=$?; if [ $EC -gt 0 ]; then printf " (%d)" $EC; fi }
PS1='[\w$(PS1_EXIT_STATUS_)]\$ '

export GPG_TTY=$(tty)
