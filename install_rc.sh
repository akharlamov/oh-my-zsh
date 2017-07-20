#!/bin/bash

echo ".aliases and .zshrc WILL BE OVERWRITTEN!!! CONTINUE (yes/no)?"
read answer 

if [ "$answer" != "yes" ]; then
	echo "No changes were made"
	exit
fi

unlink ~/.aliases
unlink ~/.zshrc

ln ~/.oh-my-zsh/aliases ~/.aliases
ln ~/.oh-my-zsh/zshrc ~/.zshrc

