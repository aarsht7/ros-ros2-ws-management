# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#-----------------------------------------------------------
# Modify according to your setup.bash location
# NOTE : Do not leave space before or after '='
ros1_path=/opt/ros/noetic/setup.bash
ros2_path=/opt/ros/foxy/setup.bash

BRed='\033[1;31m'
BCyan='\033[1;36m'
NC='\033[0m'

if [ -d "$PWD"/devel ]; then
  ROS=[ROS1]
  source "$ros1_path"
	source "$PWD"/devel/setup.bash
	echo "sourcing "$PWD"/devel/setup.bash "
fi

if [ -d "$PWD"/install ]; then
  ROS=[ROS2]
	source "$ros1_path"
	source "$PWD"/install/setup.bash
	echo "sourcing "$PWD"/install/setup.bash "
fi

sb1()
{
ROS=[ROS1]
source "$ros1_path"
source "$PWD"/devel/setup.bash && echo "sourcing "$PWD"/devel/setup.bash"
}

sb2()
{
ROS=[ROS2]
source "$ros2_path"
source "$PWD"/install/setup.bash && echo "sourcing "$PWD"/install/setup.bash"
}

ros1ws()
{
local f="$1"
if [ -d "$f" ]; then
  if [ -d "$f"/devel ]; then
    cd "$f"
    source "$ros1_path"
    source "$PWD"/devel/setup.bash && echo "sourcing "$PWD" devel/setup.bash"
    ROS=[ROS1]
  else 
    echo -e "${BRed}[ERROR]${NC} Either "$f" is not a ROS1 workspace or it is not built yet."
  fi
fi
if [[ "$f" == "" ]]; then
  ROS=[ROS1]
  source "$ros1_path"
fi
}

ros2ws()
{
local f="$1"
if [ -d "$f" ]; then
  if [ -d "$f"/install ]; then
    cd "$f"
    source "$ros2_path"
    source "$PWD"/install/setup.bash && echo "sourcing "$PWD" install/setup.bash"
    ROS=[ROS2]
  else 
    echo -e "${BRed}[ERROR]${NC} Either "$f" is not a ROS2 workspace or it is not built yet."
  fi
fi
if [[ "$f" == "" ]]; then
  ROS=[ROS2]
  source "$ros2_path"
fi
}

exit_ros()
{ 
# Unset or change the variables associated with ROS
if [[ $ROS == '[ROS1]' ]]; then
  unset ROS_VERSION
  export PKG_CONFIG_PATH=$(echo $PKG_CONFIG_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_PYTHON_VERSION
  unset ROS_PACKAGE_PATH
  unset ROSLISP_PACKAGE_DIRECTORIES
  unset ROS_ETC_DIR
  export CMAKE_PREFIX_PATH=$(echo $CMAKE_PREFIX_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  export PYTHONPATH=$(echo $PYTHONPATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_MASTER_URI
  export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  export PATH=$(echo $PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_ROOT
  unset ROS_DISTRO
  echo -e "${BRed}Exited${NC} from ${BCyan}$ROS"

  ROS=
fi

if [[ $ROS == '[ROS2]' ]]; then
  unset ROS_VERSION
  export PKG_CONFIG_PATH=$(echo $PKG_CONFIG_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_PYTHON_VERSION
  export AMENT_PREFIX_PATH=$(echo $AMENT_PREFIX_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  export CMAKE_PREFIX_PATH=$(echo $CMAKE_PREFIX_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  export COLCON_PREFIX_PATH=$(echo $COLCON_PREFIX_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  export PYTHONPATH=$(echo $PYTHONPATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_MASTER_URI
  export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_LOCALHOST_ONLY
  export PATH=$(echo $PATH | perl -ne 's/\:?[^\:]*ros[^\:]*(?=\:)?//g; print;')
  unset ROS_DISTRO
  echo -e "${BRed}Exited${NC} from ${BCyan}$ROS"

  ROS=
fi
}
#------------------------------------------------------------
# Paste the copied part above to the PS1 variable in your bashrc file.
# Find PS1 in your bashrc and add '\[\033[0;96m\]$ROS' to the PS1 as shown below

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;96m\]$ROS\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}$ROS\u@\h:\w\$ '
fi
#---------------------------------------------------------------

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

sa()
{
source ~/.bashrc && echo "sourced bashrc"
}
