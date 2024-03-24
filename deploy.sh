#!/usr/bin/env bash

if [ -f  ~/.config ]; then
  mkdir ~/.config
fi

rm -rf ~/.config/nvim
ln -s $(pwd) ~/.config/nvim

