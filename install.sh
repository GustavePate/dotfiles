#!/bin/bash

echo 'Dotfiles -  http://gustavepate.github.io/'
echo 'Inspired by Dotfiles - "Cowboy" Ben Alman - http://benalman.com/'

HOME_DIR=~
ROOT=./dotfiles
FILES=$ROOT/*

SCRIPT_FULL_PATH=$(readlink -f $0)
REPO_PATH=$(dirname $SCRIPT_FULL_PATH)

echo $REPO_PATH

# If Git is not installed...
if [[ ! "$(type -P git)" ]]; then
    sudo apt-get -qq install git
else
    echo "git installed.....ok"
fi


echo $ROOT
echo $FILES

#Command must be run from the repo root
if [ ! -e $ROOT'/.bashrc' ] 
then
    echo "install must be execute from the repo root"
    exit 1
else
    echo "command run from secure path.....ok"
fi

#Pull latest change

git pull

#Symlink all files and directory in the dotfiles directory to the home folder

#allow to find .dotfiles
shopt -s dotglob
#for all files and directory in the dotfiles directory
for f in $FILES
do
    # take action on each file. $f store current file name
    echo "Processing $f file..."

    #strip the left part
    FI=`basename $f`

    #create /home equiv
    H_FILE=$HOME_DIR'/'$FI
    TIMESTAMP=`date +%d%m%Y-%H%M%S`
    H_FILE_BACKUP=$HOME_DIR'/'$FI'.'$TIMESTAMP'.bck'

    echo "Checking $H_FILE"

    #check equivalent in the homedir

        #if a link, delete it
        if [ -L $H_FILE ];then
            rm $H_FILE   
            echo $H_FILE" rmed...........ok"

        #if a dir or a file => mv
        elif [ -e $H_FILE ]; then
            echo $H_FILE" backuped...........ok"
            mv $H_FILE $H_FILE_BACKUP
        fi

    #create a new link
    ln -s $REPO_PATH'/'$f $H_FILE

done
