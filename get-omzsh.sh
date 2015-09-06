#! /bin/bash

# Brian Cain 2014
# Set up oh-my-zsh

OMZDIR=~/.dotfiles/oh-my-zsh

if [ -d "$OMZDIR" ] ; then
  echo 'Updating oh-my-zsh to latest version'
  cd "$OMZDIR"
  git pull origin master
  cd -
else
  echo 'Adding oh-my-zsh to dotfiles'
  git clone https://github.com/robbyrussell/oh-my-zsh.git "$OMZDIR"

  echo 'Moving theme into oh-my-zsh'
  cp zsh-theme/* oh-my-zsh/themes/
fi

echo 'Complete Update!'
