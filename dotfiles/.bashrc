# sudo apt install ack-grep nodejs npm python3 python3-dev mplayer pandoc git
# git clone https://github.com/pyenv/pyenv.git ~/.pyenv 
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

PATH=$PATH:$HOME/bin
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias fuck='$(thefuck $(fc -ln -1))'
alias g='./gradlew'

###### HISTORY #######

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines in the history and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# resize history size
export HISTSIZE=5000

export AUTOFEATURE=true autotest

#reload .inputrc
bind -f ~/.inputrc

# Override with local conf

# Load local non commited .bashrc
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

if [ -f ~/.bashrc.minimal ]; then
    source ~/.bashrc.minimal
fi

if [ -f ~/bin/z.sh ]; then
    source ~/bin/z.sh
fi

# your top commands
function rh {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
 }

function say { mplayer "http://translate.google.com/translate_tts?tl=en&q=$*" >/dev/null 2>&1; }
function sayde { mplayer "http://translate.google.com/translate_tts?tl=de&q=$*" >/dev/null 2>&1; }

function publish2pdf {

    if [ $# -ne 2 ]; then
        echo "publish2pdf <url> <pdf>"
        return 1
    fi

    if hash wkhtmltopdf 2>/dev/null; then

        if [ -e ~/pub/materials/header.html ];then

            URL=$1
            PDF_NAME=$2
            wkhtmltopdf  -T 25 --header-spacing 20 --header-html ~/pub/materials/header.html $URL ~/pub/$PDF_NAME
        else
            echo "~/pub directory not initialized"
        fi
    else
        echo "please install wkhtmltopdf"
    fi
}

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

###### RUBY ######

#source /home/guillaume/.rvm/scripts/rvm
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi



alias ack='ack-grep'
alias paste='xclip -o -selection clipboard'
alias node='nodejs'


#serve repository
alias serve='python -m http.server 8080'
alias serve_secure="python -c 'import http.server as hs; hs.HTTPServer((\"127.0.0.1\", 2323), hs.SimpleHTTPRequestHandler).serve_forever()'"
alias sphinx_serve='cd ~/doc_html/; serve_secure'
alias sphinx_autocompile='autocompile.py $SYNC_PATH/Boulot/sphinx/ .rst "make althtml;reload_browser.py"'
alias autosphinx='sphinx_serve & sphinx_autocompile'
alias d="cd ~/doc;vim"


#apt-get install
alias install='sudo apt-get install'
alias reboot='sudo shutdown -r now'
alias halt='sudo shutdown  now'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


###### GARBAGE ??? #######

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-256color)
    PS1="\[\e[38;5;31m\]\t\[\e[0m\] ${debian_chroot:+($debian_chroot)}\[\e[38;5;38m\]\u\[\e[0m\]\[\e[38;5;6m\]@\[\e[0m\]\[\e[38;5;24m\]\h\[\e[0m\]\[\e[38;5;14m\]:\[\e[0m\]\[\e[38;5;243m\]\W\[\e[0m\]\$\[\e[0m\] "
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
xterm)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
#xterm-256color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;7m\]\u\[\033[38;5;15m\]@\[\033[38;5;45m\]\h\[\033[38;5;15m\]:\[\033[38;5;6m\]\w\[\033[38;5;15m\]\$\[$(tput sgr0)\] '
#    ;;
#xterm)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;7m\]\u\[\033[38;5;15m\]@\[\033[38;5;45m\]\h\[\033[38;5;15m\]:\[\033[38;5;6m\]\w\[\033[38;5;15m\]\$\[$(tput sgr0)\] '
#    ;;
rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    #echo "$TERM"
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\wyop\$ '
    ;;
esac

###### PYTHON ######

#dev env
#export VENV=~/venv/dev/bin/activate
#if [ -f $VENV ]; then
#	. $VENV
#fi

# pyenv conf
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#source $PYENV_ROOT/completions/pyenv.bash



export DISTARKPATH=/home/project/git/distark/src/


#export PYTHONPATH=/home/project/git/distark/src/
#export PYTHONPATH=$PYTHONPATH:$DISTARKPATH
#export PYTHONPATH="$PYTHONPATH:$DISTARKPATH""distark/commons/protos/"
export PATH=$PATH:/usr/share/zookeeper/bin
export PATH=$PATH:/home/opt/zookeeper-3.4.5/bin


#venv
export VENVFRONT=/home/project/git/front/env/bin/activate
if [ -f $VENVFRONT ]; then
    alias devfront="source $VENVFRONT; cd /home/project/git/front/env/pyramidfront"
fi

#venv
export ACTIVATEPYRAM=/home/project/venv/pyram/bin/activate
if [ -f $ACTIVATEPYRAM ]; then
    alias devpyram="source $ACTIVATEPYRAM; cd /home/project/git/dashboard/"
fi

export VENVDIST=/home/project/venv/distark/bin/activate
if [ -f $VENVDIST ]; then
    alias devback="source $VENVDIST; cd /home/project/git/distark"
    alias devcli="source $VENVDIST; cd /home/project/git/distarkcli;export PYTHONPATH=/home/project/git/distarkcli/"
fi

say(){
    wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=de&q=$1"; mpg123 output.mp3
}

function auto_rst2slides(){

    if [ $# -ne 2 ]; then
        echo "auto_rst2slides doc.rst (~/pub/)name(.html)"
        return 1
    fi
    export TOEXEC="rst2slides -i $1 -o $2"
    echo "automcmd: $TOEXEC"
    autocompile.py . .rst "$TOEXEC"
}



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/guillaume/.sdkman"
[[ -s "/home/guillaume/.sdkman/bin/sdkman-init.sh" ]] && source "/home/guillaume/.sdkman/bin/sdkman-init.sh"
