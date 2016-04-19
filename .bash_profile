
# common
source ~/.bashrc
export HISTSIZE=""
export PATH=.:~/mikebin:~/bin:~/.cargo/bin:$PATH
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export MAVEN_OPTS="-Xmx1G -XX:PermSize=512M"

# work only
HOST=`hostname`
if [[ "$HOST" == "msmoot02-mbp.local" || "$HOST" == *synthgeno.global ]]
then

    export PATH=~/code/dockerized_tools/bin:$PATH

    export PYTHONPATH=~/code

    export RUST_BACKTRACE=1

    if [ -d ~/go_work ]
    then
        export GOPATH=~/go_work
        export PATH=$GOPATH/bin:$PATH
    fi
fi

#
#if [ -x `which ssh-agent` ]
#then
#  SSH_AGENT_STATE="/tmp/.ssh-agent-state.$USER"
#  export SSH_AGENT_STATE
#
#  if [ -f $SSH_AGENT_STATE ]
#  then
#    . "$SSH_AGENT_STATE"
#  fi
#
#  if [ -z $SSH_AUTH_SOCK ]
#  then
#    ssh-agent -s | grep -v '^echo ' > "$SSH_AGENT_STATE"
#    . "$SSH_AGENT_STATE"
#  else
#    if [ ! -S "$SSH_AUTH_SOCK" ]
#    then
#      ( kill -9 $SSH_AGENT_PID )
#      unset SSH_AUTH_SOCK
#      unset SSH_AGENT_PID
#      ( kill -0 $SSH_AGENT_PID )
#      /bin/rm -f "$SSH_AGENT_STATE"
#      unset SSH_AGENT_PID
#      unset SSH_AUTH_SOCK
#    fi
#  fi
#fi
#
