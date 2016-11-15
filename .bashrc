
# Get system defaults
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi


# Determine if the current dir is on a git branch
function parse_git_branch {
    BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=$(parse_git_dirty)
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# Assess the current status of the repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
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

# does not work!
function print_error_code {
    local       DEFAULT="\[\033[0m\]"
    local       ON_IRED="\[\033[0;101m\]"
    ec=$(printf '%.*s' $? $?)
    if [ "x${ec}" != "x" ]
    then
        echo "$ON_IRED(${ec})$DEFAULT"
    fi
}

function get_host_color {
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

  echo $HOSTCOLOR
}

function get_user_color {
    local     ON_IRED="\[\033[0;101m\]"
    local     I_BLACK="\[\033[0;90m\]"

    # highlight if you're root
    if [ "$(id -u)" == "0" ]
    then
        echo $ON_IRED
    else
        echo $I_BLACK
    fi
}

# Colorize PS1
function set_prompt_color {

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
  local    ON_ICYAN="\[\033[106m\]"
  local     ON_IRED="\[\033[0;101m\]"
  local     DEFAULT="\[\033[0m\]"

  PS1="$(get_user_color)\u$LIGHT_GRAY@$(get_host_color)\h: $MAGENTA\w\n$DEFAULT$ON_ICYAN\$(parse_remote_docker)$RED\$(parse_git_branch)$DEFAULT$ "
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
alias tmp='cd ~/tmp'
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
alias asm09='ssh -A asm09.c01.l.synthgeno.global'
alias asm-util01='ssh -A asm-util01.l.synthgeno.global'
alias xdev07='ssh -A xdev07.l.synthgeno.global'
alias xdev23='ssh -A xdev23.l.synthgeno.global'
alias ssp-dev02='ssh -A ssp-dev02.awsv.l.synthgeno.global'
alias ssp-stage02='ssh -A ssp-stage02.l.synthgeno.global'
alias shiny-dev01='ssh -A shiny-dev01.l.synthgeno.global'
alias ssp01='ssh -A ssp01.l.synthgeno.global'
alias service-dev='ssh -A service.dev.sgi.bio'
alias search01='ssh -A search01-s01.lwdc.l.synthgeno.global'
alias proc01='ssh -A proc01.c01.l.synthgeno.global'
alias gbrowse02='ssh -A gbrowse02.lwdc.l.synthgeno.global'
alias jbrowse01='ssh -A jbrowse01.awsv.l.synthgeno.global'
alias asm-micro='ssh -A asm-microsvcs01.l.synthgeno.global'
alias mirror='ssh -A mirror.l.synthgeno.global'
# assumes you've run 'ssh-add ~/.ssh/msmoot-aws.pem'
alias aws-base='ssh -l centos -A 172.19.0.208'
alias nf-aws-base='ssh -l centos -A 172.19.0.190'


alias aws_home_root='ssh -i ~/AWS/aws_mes.pem ubuntu@ec2-54-67-35-224.us-west-1.compute.amazonaws.com'
alias aws_home_mes='ssh mes@ec2-54-67-35-224.us-west-1.compute.amazonaws.com'

# commands
alias things="vi ~/.things"
alias todo="vi ~/.todo"

alias servedir="python -m SimpleHTTPServer"

# Amazon Web Services auto complete
complete -C aws_completer aws

# Setup for docker
if [ -x "$(command -v docker-machine)" ]
then
    running=$(docker-machine ls | grep default | grep Running)
    if [ $? == 0 ]
    then
        eval "$(docker-machine env default)"
    fi
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

# local microservice dev environment setup
if [ -e ~/code/microservicesci/microservicesci_setup.sh ]
then
    source ~/code/microservicesci/microservicesci_setup.sh
fi

# set up python venv if it exists
if [ -d ~/python_venv ]
then
    source ~/python_venv/bin/activate
fi
