
# Load local non commited .bashrc

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#Force 256 colors
export TERM=xterm-256color

#reload .inputrc
bind -f ~/.inputrc

#automatic colors with grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export EDITOR=vim

###### HISTORY #######

# append to the history file, don't overwrite it 
shopt -s histappend

# don't put duplicate lines in the history and ignore same sucessive entries. 
export HISTCONTROL=ignoreboth

# resize history size
export HISTSIZE=5000

export AUTOFEATURE=true autotest

# your top commands
function rh {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
 }

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"



###### RUBY ######

#source /home/guillaume/.rvm/scripts/rvm
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# .. act as cd ..
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# LS
#h - human readble
#S - Sort by size
#F - add trailing / for fir * for exec ...
#A - Almost all show dot files but not . and ..
#C - List by columns
#1 only one column
alias ll='ls -lhSF --color=auto'
alias la='ls -lAF --color=auto'
alias ls='ls -CF --color=auto'
alias l="ls -AF1S"
alias ack='ack-grep'
alias paste='xclip -o -selection clipboard'

#clear screen
alias c='clear'

#exit
alias q='exit'

#serve repository
alias serve='python -m SimpleHTTPServer 8080'

#apt-get install
alias install='sudo apt-get install'
alias reboot='sudo shutdown -r now'
alias halt='sudo shutdown  now'



# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


###### GARBAGE ??? #######


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

###### PYTHON ######

#dev env
export VENV=~/venv/dev/bin/activate
if [ -f $VENV ]; then
	. $VENV
fi

export DISTARKPATH=/home/project/git/distark/src/


export PYTHONPATH=/home/guillaume/git/distark/src/
export PYTHONPATH=$PYTHONPATH:$DISTARKPATH
export PYTHONPATH="$PYTHONPATH:$DISTARKPATH""distark/commons/protos/"
export PATH=$PATH:/usr/share/zookeeper/bin
export PATH=$PATH:/home/opt/zookeeper-3.4.5/bin

#venv
export VENVFRONT=/home/project/git/front/env/bin/activate
if [ -f $VENVFRONT ]; then
    alias devfront="source $VENVFRONT; cd /home/project/git/front/env/pyramidfront"
fi

export VENVDIST=/home/project/venv/distark/bin/activate
if [ -f $VENVDIST ]; then
    alias devback="source $VENVDIST; cd /home/project/git/distark"
fi
