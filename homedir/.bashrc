#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -a'
alias grep=rg
PS1='[\u@\h:\W]\$ '
