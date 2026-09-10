# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jeppe/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
# End of lines added by compinstall

#
# # If not running interactively, don't do anything
# [[ $- != *i* ]] && return
#
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
# export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# ZSH autosuggestions
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH syntax highlighting
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NIX_SHELL_PRESERVE_PROMPT=1

# Starship
eval "$(starship init zsh)"
