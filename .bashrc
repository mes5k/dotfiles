# .bashrc

# Source global definitions
# Right now this only sets PS1
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

mesg y

# User specific aliases and functions

# For some reason we need to explicitly set PS1 here, as it is not
# maintained in non-interactive shells.

#export PS1="\u@\h:\w\n> "
export  PS1="\u@\033[33m\]\h\033[0m\]: \w\n> " 
#
# where 

#  \033[XYm\] -- starts color
#  \033[0m\]  -- ends color
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
 
export MAC="wrpmg4e.bioch.virginia.edu"

if [ $TERM == "xterm" ]
then
	export PROMPT_COMMAND='echo -ne "\033]0; ${HOSTNAME} \007"'
fi

set -o vi

alias la='ls -FaG'
alias ll='ls -lrtG'
alias ls='ls -FG'

alias pyb='pybliographic ~/phd/endnotes/endnotes.bib'

alias bin='cd ~/bin'
alias try='cd ~/try'
alias tools='cd ~/tools'
alias down='cd ~/Downloads'

alias mtb='ssh mtb.sys.virginia.edu'
alias bord='ssh -X mes@gamay.ucsd.edu'
alias gamay='ssh -X mes@gamay.ucsd.edu'
alias bordeaux='ssh -X mes@gamay.ucsd.edu'
alias burns='ssh burns.sys.virginia.edu'
alias mamba='ssh mamba.cs.virginia.edu'
alias aes='ssh -l mes www.aescon.com'
alias wwww='ssh -l mes www.aescon.com'
alias www='ssh -l mes www.aescon.com'
alias blue='ssh blue.unix.virginia.edu'
alias cobra='ssh cobra.cs.virginia.edu'
alias wrpx='ssh wrpx00.bioch.virginia.edu'
#alias wrpx='dcop $KONSOLE_DCOP newSession wrpx' 
alias alpha10='ssh alpha10.bioch.virginia.edu'
alias sunray='ssh sunray.sys.virginia.edu'
alias crick='ssh crick.med.virginia.edu'
alias wrp_mac='ssh wrpmg4e.bioch.virginia.edu'
alias my_mac='ssh wrpmg4e.bioch.virginia.edu'
alias mac='ssh wrpmg4e.bioch.virginia.edu'
alias my_apple='ssh wrpmg4e.bioch.virginia.edu'
alias unfurl='unfurl.pl' 
alias phd='cd ~/phd' 
#alias startx='startx -dpi 100'
#alias ant='ant -verbose' 
alias disp='cd ~/phd/noptdisplay'
alias dsrc='cd ~/phd/noptdisplay/src/edu/virginia/bioch/nopt'
alias tsrc='cd ~/phd/noptdisplay/test/edu/virginia/bioch/nopt'
alias near='cd ~/phd/noptalign/alignments'
alias web='cd ~/phd/noptweb'
alias nopt='cd ~/phd/noptalign2'
alias prnt='prnt.sh'
alias end='cd ~/phd/endnotes/xmlStuff'
alias lpstat='lpstat -o all'
alias soft='cd ~/software'
alias top='top -d 1'
alias money='/home/mes5k/software/moneydance/moneydance&'
alias adsl-start='sudo /usr/sbin/adsl-start'
alias adsl-stop='sudo /usr/sbin/adsl-stop'

alias shutdown-restart='sudo /sbin/shutdown -r now'
alias shutdown-halt='sudo /sbin/shutdown -h now'

alias vi='vim'

alias squiggle='java -jar ~/software/batik-1.5/batik-squiggle.jar'

alias xwrits='nohup xwrits typetime=50 breaktime=1 +mouse +quota +breakclock after=5 +finger flashtime=:.20 after=10 +top -quota flashtime=:.10 break=5&'

alias konq='konqueror'

alias todo='vi ~/.todo'

alias urpmi='sudo /usr/sbin/urpmi'

# csbi alii
alias csbi_cvs="/usr/bin/cvs -d:ext:mes5k@cvs.sourceforge.net:/cvsroot/csbi"
alias cyto_cvs="/usr/bin/cvs -d :ext:mes@gamay.ucsd.edu:/common/cvsdir5"
alias wrp_cvs="/usr/bin/cvs -d :ext:mes5k@wrpsun2.bioch.virginia.edu:/rd0/users/CVS/source"
alias tclap_cvs="/usr/bin/cvs -d:ext:mes5k@tclap.cvs.sourceforge.net:/cvsroot/tclap"

alias cvs="echo WRONG! Use an alias: csbi_cvs, cyto_cvs, wrp_cvs, tclap_cvs"

alias sd=". execSwitchDirs.sh"
alias things="vi ~/.things"


# Disables the bloody CapsLock button
#x11=`ps -ef | grep X11 | grep -Ev "up|grep|ps -ef"`
#if [[ "$x11" != "" ]]
#then
#	if [ "$PS1" ]
#	then
#		xmodmap -e "remove lock = Caps_Lock"
#	fi
#fi


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
