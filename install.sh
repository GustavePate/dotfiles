#!/bin/bash

echo 'Dotfiles -  http://gustavepate.github.io/'

HOME_DIR=~  #For testing purpose
SYNC_ROOT=./dotfiles
SYNC_FILES=$SYNC_ROOT/*

SCRIPT_FULL_PATH=$(readlink -f $0)
REPO_PATH=$(dirname $SCRIPT_FULL_PATH)

echo $REPO_PATH

can_haz_dots=0


function linkit {
    src=$1
    dest=$2

    #if a link, delete it
    if [ -L $dest ];then
        rm $dest
        echo $dest " rmed...........ok"
    #if a dir or a file => mv
    elif [ -e $dest ]; then
        TIMESTAMP=`date +%d%m%Y-%H%M%S`
        BACKUP_dest=$dest'.'$TIMESTAMP'.bck'
        mv $dest $BACKUP_dest
        echo $dest" backuped...........ok"
    #file does not exists
    elif [ ! -e $dest ]; then
        echo $dest" does not exits yet...ok"
    # weird
    else
        echo "WARNING: I don't know what to do with this file $dest"
    fi

    #create a new link
    ln -s $src $dest
    echo $dest' symlinked to '$src


}


#detect change in the local directory and push if any
function detect_change {

    has_changed=`git status | grep "nothing to commit" | wc -l`

    echo "has_changed:" $has_changed
    if [[ $has_changed -ne 1 ]];then

        echo "change detected"
        #Pull latest change
        git status
        read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            can_haz_dots=1
        fi;

    else
        echo "no change detected"
        can_haz_dots=1
    fi

}

function install_dots {

    echo "PUUUULLLLL !!!!"
    git pull

    #Symlink all files and directory in the dotfiles directory to the home folder
    #allow bash  to find .dotfiles
    shopt -s dotglob

    #for all files and directory in the dotfiles directory
    for f in $SYNC_FILES
    do
        # take action on each file. $f store current file name
        echo "Processing $f file..."

        #strip the left part
        FILE=`basename $f`

        #create /home equiv for repo file
        H_FILE=$HOME_DIR'/'$FILE

        linkit $REPO_PATH'/'$f $H_FILE

    done

    #TODO: replace with fucntion call
    # manual install
    src=$REPO_PATH'/dotfiles/redshift.conf'
    target=~/.config/redshift.conf
    linkit $src $target

    #update fonts
    echo "update font cache please wait...."
    fc-cache -f
    echo "Done!"

}

######################
####### MAIN #########
######################

# If Git is not installed...
if [[ ! "$(type -P git)" ]]; then
    echo "install git"
    echo "sudo apt-get install git"
    exit 1
else
    echo "git installed.....ok"
fi

#Command must be run from the repo root
if [ ! -e $SYNC_ROOT'/.bashrc' ]
then
    echo "install must be execute from the repo root"
    exit 1
else
    echo "command run from secure path.....ok"
fi

detect_change

if [[ can_haz_dots -eq 1 ]]; then
    install_dots
fi

