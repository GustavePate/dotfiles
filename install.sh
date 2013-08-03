#!/bin/bash

echo 'Dotfiles -  http://gustavepate.github.io/'


function submodules_latest {
    # get latest submodules
    git submodule init
    git submodule update

    git submodule foreach git pull origin master

    git add .

    # Commit the submodule changes 
    git commit -a -m "Update submodules to the latest version"

    git push origin master

}

function push_changes_if_any {

    has_changed=`git status | grep "nothing to commit" | wc -l`

    echo "has_changed:" $has_changed
    if [[ $has_changed -ne 1 ]];then

        echo "change detected"
        #Pull latest change
        git add .

        #interactivelly add the commit command in order to reviex your changes
        git commit -a 
        if [ $? -ne 0 ]; then
            echo "User aborted"
            # it stops if there is nothing to commit (which don't pass the above test)
            # or if commit comment is empty
            # avoid to commit no neededd change
            exit 1

        else
            # Push to remote repository 
            git push origin master
        fi

    else
        echo "no change detected"
    fi

}


HOME_DIR=~  #For testing purpose
SYNC_ROOT=./dotfiles 
SYNC_FILES=$SYNC_ROOT/*

SCRIPT_FULL_PATH=$(readlink -f $0)
REPO_PATH=$(dirname $SCRIPT_FULL_PATH)

echo $REPO_PATH

# If Git is not installed...
if [[ ! "$(type -P git)" ]]; then
    sudo apt-get -qq install git
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

git pull
if [ $? -ne 0 ]; then
    echo "Pull error !!!!"
    exit 1
fi



#push changes
push_changes_if_any


#get submodules latest version
submodules_latest


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

    #create backup path 
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
        # weird
        else
            echo "WARNING: I don't know what to do with this file"
        fi

    #create a new link
    ln -s $REPO_PATH'/'$f $H_FILE
    echo $H_FILE' symlinked to '$REPO_PATH'/'$f

done
