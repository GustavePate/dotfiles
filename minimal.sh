#!/bin/bash

echo 'Dotfiles - MINIMAL - http://gustavepate.github.io/'

HOME_DIR=~/testdot  #For testing purpose
SYNC_ROOT=./dotfiles
SYNC_FILES=$SYNC_ROOT/*

SCRIPT_FULL_PATH=$(readlink -f $0)
REPO_PATH=$(dirname $SCRIPT_FULL_PATH)

echo $REPO_PATH

echo "I am minimal"

# define list of file to install
file_list = ".bashrc.minimal .inputrc .vimrc"
dir_list = ".vim"

# backup

# copy

# remove deployement artefact

# source


# done
