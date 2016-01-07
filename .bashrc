
# Get system defaults
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi


# Determine if the current dir is on a git branch
function parse_git_branch {
  if [[ -x /usr/bin/git ]]
  then
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\[\1\]/'
  fi
}

# Determine if the docker host in this
# shell is set to a remote host or not.
function parse_remote_docker {
    if [[ $DOCKER_HOST == tcp://192.168*  || "x$DOCKER_HOST" == "x" ]]
    then
        echo ""
    else
        echo "{REMOTE DOCKER!}"
    fi
}

# Colorize PS1
function set_prompt_color {

  #  \033[Z;XYm\] -- starts color
  #  \033[0m\]  -- ends color
  #
  #  Z = 0  -- "light"
  #      1  -- "dark"
  #
  #  X = 3  -- colors text
  #      4  -- colors background
  #
  #  Y = 0  -- black
  #      1  -- red
  #      2  -- green
  #      3  -- browish/yellowish/orange
  #      4  -- blue
  #      5  -- magenta
  #      6  -- aqua
  #      7  -- grey
  #      8  -- white
  #      9  -- white

  # 0 or 1
  local Z=$(hostname | sum | awk '{print $1 % 2}')

  # 1..7 (omit black and white)
  local Y=$(hostname | sum | awk '{print (($1 - 2) % 7)+1}')

  # Assign colorization abased on hostname
  local HOSTCOLOR="\[\033[${Z};3${Y}m\]"

  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local      ORANGE="\[\033[0;33m\]"
  local        BLUE="\[\033[0;34m\]"
  local     MAGENTA="\[\033[0;35m\]"
  local        AQUA="\[\033[1;36m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local     ON_ICYAN="\[\033[106m\]"
  local     DEFAULT="\[\033[0m\]"

  PS1="$HOSTCOLOR\u@\h: $MAGENTA\w\n$DEFAULT$ON_ICYAN\$(parse_remote_docker)$RED\$(parse_git_branch)$DEFAULT> "
}

set_prompt_color

# vim command line
set -o vi

# commands and tools
os=$(uname)

if [ "${os}" == "Darwin" ]
then
    alias la='ls -GFa'
    alias ll='ls -Glrt'
    alias ls='ls -GF'
elif [ "${os}" == "Linux" ]
then
    alias la='ls -Fa --color=auto'
    alias ll='ls -lrt --color=auto'
    alias ls='ls -F --color=auto'
else
    alias la='ls -Fa'
    alias ll='ls -lrt'
    alias ls='ls -F'
fi

alias vi='vim'

# change dirs
alias bin='cd ~/bin'
alias soft='cd ~/software'
alias down='cd ~/Downloads'
alias try='cd ~/try'
alias code='cd ~/code'

# servers
alias www='ssh mes@www.aescon.com'

# work servers
alias asm01='ssh -A asm01.c01.l.synthgeno.global'
alias asm02='ssh -A asm02.c01.l.synthgeno.global'
alias asm03='ssh -A asm03.c01.l.synthgeno.global'
alias asm04='ssh -A asm04.c01.l.synthgeno.global'
alias asm05='ssh -A asm05.c01.l.synthgeno.global'
alias asm06='ssh -A asm06.c01.l.synthgeno.global'
alias asm07='ssh -A asm07.c01.l.synthgeno.global'
alias asm08='ssh -A asm08.c01.l.synthgeno.global'
alias xdev07='ssh -A xdev07.l.synthgeno.global'
alias ssp-dev01='ssh -A ssp-dev01.l.synthgeno.global'

# commands
alias things="vi ~/.things"
alias todo="vi ~/.todo"

# Amazon Web Services auto complete
complete -C aws_completer aws

# Setup for docker
if [ -x "$(command -v docker-machine)" ]
then
    eval "$(docker-machine env default)"
fi

if [ -x "$(command -v docker)" ]
then
    alias dockviz='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz'
fi

# local dev environment setup
if [ -e ~/code/dev_env/dev_env_setup.sh ]
then
    source ~/code/dev_env/dev_env_setup.sh
fi
