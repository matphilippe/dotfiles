#!/bin/bash

export WORK="$HOME/Projects/persgroep"
export NOTES="$HOME/Projects/self/notes"
export DOTFILES="$HOME/Projects/dotfiles/"
export PATH="${DOTFILES}/scripts:$PATH"

gowork(){
  cd $WORK
}

gonote(){
  cd $NOTES
}

godot(){
  cd $DOTFILES
}
