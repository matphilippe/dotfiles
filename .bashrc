#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# keybinds
bind -x '"\C-l":clear'

if [[ "$OSTYPE" == "darwin"* ]]; then
	# needed for brew
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# config
export BROWSER="firefox"

# directories
export REPOS="$HOME/Projects"
export GITUSER="matphilippe"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$HOME/.dotfiles"
export LIBS="$DOTFILES/libs"
export SCRIPTS="$DOTFILES/scripts"
export NOTES="$HOME/Notes"
export WORK_FOLDER="$REPOS/work"
export SELF_FOLDER="$REPOS/self"
# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/go/"

PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin" # appending
. $SCRIPTS/sourceall $LIBS

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# This function is stolen from rwxrob

clone() {
	local repo="$1" user
	local repo="${repo#https://github.com/}"
	local repo="${repo#git@github.com:}"
	if [[ $repo =~ / ]]; then
		user="${repo%%/*}"
	else
		user="$GITUSER"
		[[ -z "$user" ]] && user="$USER"
	fi
	local name="${repo##*/}"
	local userd="$REPOS/github.com/$user"
	local path="$userd/$name"
	[[ -d "$path" ]] && cd "$path" && return
	mkdir -p "$userd"
	cd "$userd"
	echo gh repo clone "$user/$name" -- --recurse-submodule
	gh repo clone "$user/$name" -- --recurse-submodule
	cd "$name"
} && export -f clone

# starship

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim

alias scripts='cd $SCRIPTS'

# Repos

alias dot='cd $DOTFILES'
alias repos='cd $REPOS'
alias work='cd $WORK_FOLDER'
alias self='cd $SELF_FOLDER'
alias gr='cd $(gitroot)'
# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# fun
alias fishies=asciiquarium

# kubectl
alias k='kubectl'
source <(kubectl completion bash)

complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

export PATH="/usr/local/bin:$PATH"
export PATH="${HOME}/.cargo/bin:${PATH}"

# Work related environment Variables

source ~/.env.common

. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
. "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash"
