# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

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
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi
alias svn-b='svn-buildpackage -rfakeroot --svn-ignore-new  -uc -us'
alias git-b="git-buildpackage --git-export-dir=../build-area -us -uc" 
#alias git-a="git archive --format=tar --prefix=spinic-0.1.2/ 0.1.2^{tree} | gzip > ../spinic-0.1.2.tar.gz" 
alias git-bs="git-buildpackage --git-export-dir=../build-area -S -sa" 
alias git-t="git-buildpackage --git-tag-only" 
alias make='make -j 6'
alias demo='totem "http://gaia.local:8084/sdp?rtpsession=defaultrtp&destination=zeus"'
alias nosleep="xset -dpms; xset s off; echo NO SLEEP:  xset -dpms and xset s off"
alias chouinard="nosleep && pushd ~/src/chouinard && ./launch-zeus.lunch -g && popd"
alias dr="~/bin/drush/drush"
alias gitm="git log --graph --pretty=medium --decorate --all"

# Profiles the given application
function profilecpu {
CPUPROFILE=/tmp/$1.prof LD_PRELOAD="/usr/lib/libprofiler.so.0" $@
}

function profilemem {
HEAPPROFILE=/tmp/$1.prof LD_PRELOAD="/usr/lib/libtcmalloc.so.4" $@
}

function profileleak {
HEAPCHECK=normal LD_PRELOAD="/usr/lib/libtcmalloc.so.4" $@
}
export MOZILLA_FIVE_HOME=/usr/lib/mozilla


# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "

alias cleanswap='sudo sync && sudo swapoff -av && sudo swapon -av'

export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3/dist-packages

# set terminal to 256 colors so my emacs looks nicer
export TERM=xterm

PATH=~/bin:~/.local/bin:$PATH