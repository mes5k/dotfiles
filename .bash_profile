
source $HOME/.bashrc

export HISTSIZE=""

export PATH=.:~/mikebin:~/bin:$PATH
export PYTHONPATH=~/code

if [ -x `which ssh-agent` ]
then
  SSH_AGENT_STATE="/tmp/.ssh-agent-state.$USER"
  export SSH_AGENT_STATE

  if [ -f $SSH_AGENT_STATE ]
  then
    . "$SSH_AGENT_STATE"
  fi

  if [ -z $SSH_AUTH_SOCK ]
  then
    ssh-agent -s | grep -v '^echo ' > "$SSH_AGENT_STATE"
    . "$SSH_AGENT_STATE"
  else
    if [ ! -S "$SSH_AUTH_SOCK" ]
    then
      ( kill -9 $SSH_AGENT_PID )
      unset SSH_AUTH_SOCK
      unset SSH_AGENT_PID
      ( kill -0 $SSH_AGENT_PID )
      /bin/rm -f "$SSH_AGENT_STATE"
      unset SSH_AGENT_PID
      unset SSH_AUTH_SOCK
    fi
  fi
fi

