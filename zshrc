# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob incappendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/jschwarz/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="john"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(adb common-aliases osx ssh-agent)

source $ZSH/oh-my-zsh.sh

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

bindkey '^[b' backward-word
bindkey '^[f' backward-word

# User configuration

export PATH="/usr/lib/ccache:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/local/sbin:/usr/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.# For a full list of active aliases, run `alias`.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Private stuff :)
export PATH="$PATH:/home/john/powerline.git/scripts/"
export GREP_COLOR="1;31"

alias vi='nvim -O'
alias vim="nvim -O"

if [ `uname` = "Darwin" ]; then
    export TERM=xterm-256color
fi

alias grep='grep --color=auto'

# Add --nogroup to simulate find | grep
alias fa='ag -U'
alias fp='ag --python --ignore-dir tests'
alias fpa='ag --python'
alias fc='ag --cc'
alias fcc='ag --cpp'
alias fj='ag --java'
alias fh="ag -G '\.[h,hpp]$'"
alias fhh='find /usr/include -name "*.h" -type f -print0 | xargs -0 grep -n --color=auto'

alias gitlog='git --no-pager log --pretty=oneline -n'

alias duh='du -h -d 1'

alias rm='rm -f'
alias cp='cp -f'
alias mv='mv -f'
alias gnome-terminal='dbus-launch gnome-terminal'

alias make='make -j 5'
alias catkin='intercept-build --append catkin'

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
unset LC_CTYPE

export SVN_EDITOR="nvim"

export LD_LIBRARY_PATH=/usr/local/cuda/lib64
export PATH=$PATH:/usr/local/cuda/bin:/opt/gradle/gradle-5.0/bin:/home/john/gcc-arm-none-eabi-7-2017-q4-major/bin
source /opt/ros/melodic/setup.zsh
source /home/john/catkin_ws/devel/setup.zsh
export PX4_DIR=/home/john/dev/px4/Firmware
#export PX4_DIR=/home/john/repos/px4-firmware-downstream
source ${PX4_DIR}/Tools/setup_gazebo.bash ${PX4_DIR} ${PX4_DIR}/build/posix_sitl_default >/dev/null
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:${PX4_DIR}
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:${PX4_DIR}/Tools/sitl_gazebo
export TRT_INCLUDE_PATH=/home/john/TensorRT-6.0.1.8/include
export TRT_LIB_PATH=/home/john/TensorRT-6.0.1.8/lib
#export TRT_INCLUDE_PATH=/home/john/TensorRT-4.0.1.6/include
#export TRT_LIB_PATH=/home/john/TensorRT-4.0.1.6/lib
export TG_NN_MODELS_PATH=/home/john/models
export DEPTH_CAMERA_PATH=/home/john/depth_sdk
export THIRD_PARTY_PATH=/home/john/third_party
export TG_CROSS_COMPILE_PATH=~/toolchain/gcc-linaro-4.9.4-2017.01-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
export GST_PLUGIN_PATH=/home/john/catkin_ws/devel/lib

# user and password for TG nexus respository
export NEXUS_USER=ag_team
export NEXUS_PASS=BTRoorZokKqmWHbwHFirvF3B
export LANG=en_US.UTF-8
