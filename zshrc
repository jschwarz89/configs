# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify shwordsplit
unsetopt autocd beep extendedglob incappendhistory equals
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
#ZSH_THEME="john"
export ALIEN_SECTIONS_LEFT=(
  exit
  user
  time
  path
  prompt
)

export ALIEN_SECTIONS_RIGHT=(
  vcs_branch:async
)
export ALIEN_THEME="gruvbox"
source ~/repos/alien/alien.zsh


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
plugins=(adb common-aliases macos ssh-agent zsh-autosuggestions)

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
bindkey '^[f' forward-word
bindkey '^b' backward-word
bindkey '^f' forward-word

# User configuration

export PATH="/usr/lib/ccache:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/local/sbin:/usr/sbin:/home/jschwarz/.cargo/bin:/home/jschwarz/.local/bin:$PATH"
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
export PATH="$PATH:/home/jschwarz/configs/powerline.git/scripts/:/home/jschwarz/configs/ccls/Release"
export GREP_COLOR="1;31"

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

export LANG=en_US.UTF-8

#if [ $(hostname) == 'jschwarz-VM' ]; then
    #export SET_ABSOLUTE_HABANA_ENV="true"
    #source $HOME/trees/npu-stack/automation/habana_scripts/habana_env $HOME/trees $HOME/trees/npu-stack /home/jschwarz_local/builds
#else
    source $HOME/trees/npu-stack/automation/habana_scripts/habana_env
#fi

alias hl-lspci='lspci -d 1da3:'
#alias cmake="intercept-build --append cmake"
#alias make="intercept-build --append make"
alias tkdb='rm -rf /tmp/sw_kernels_build_test ; jfrog rt dl --fail-no-op --sort-by=created --sort-order=desc --limit=1 --props '\''buildType=Release;release_branch=master;OS=ubuntu18.04'\'' habanalabs-bin-local/sw_kernels_build_test/ /tmp/ ; pushd /tmp/sw_kernels_build_test/ ; tar xf sw_kernels_build_test-*.tar.gz ; cp libtpc_kernels.so $GC_KERNEL_PATH ; popd'
alias git-review="git-review -r origin"
alias jlog='_jlog(){ curl -X GET --user jschwarz\:1193a1bbf2483f4000d2c7600f25002fa3 "$1" > /tmp/jlog.txt; }; _jlog'
export PYTHONPATH=$PYTHONPATH:$HABANA_PY_QA_ROOT
export CFLAGS="$CFLAGS -fdiagnostics-color=auto"
export CXXFLAGS="$CXXFLAGS -fdiagnostics-color=auto"

fix_ccls()
{
    echo "[" > $1
    for f in $(find /home/jschwarz/builds -type f -iname "compile_commands.json"); do
        echo "Appending output from $f..."
        cat $f | head -n -2 | tail -n +2 >> $1
        echo "    }," >> $1
    done
    echo "]" >> $1
}
#FLOATERM="/home/jschwarz/configs/vim/plugged/vim-floaterm/bin/floaterm"
#export PATH="/home/jschwarz/configs/vim/plugged/vim-floaterm/bin:$PATH"
#if type "floaterm" > /dev/null; then
    #alias vim=floaterm
#else
    alias vi='nvim -O'
    alias vim="nvim -O"
#fi

do_rsync()
{
    __repo="$1"
    shift
    host_list=$(/home/jschwarz/trees/npu-stack/gc_tools/hcl/server_arguments.py $@)
    host_count=$(echo $host_list | wc -w)
    setopt sh_word_split
    for host in $host_list; do
        sshpass -p "Hab12345" rsync -av --exclude .git $__repo labuser@${1}:trees/npu-stack || return 1
    done
    echo "Done!"
    unsetopt sh_word_split
}

s()
{
    hostfile=$1
    host_list=$(cat $hostfile | cut -d " " -f 1)
    host_count=$(echo $host_list | wc -w)

    if (( $host_count > 1 )); then
        tmux split-window -h
        tmux select-pane -t {top-left}
    fi

    while (( $host_count > 2 )); do
        count=0
        panes=$(tmux list-panes -F '#P')
        for pane in $panes; do
            tmux select-pane -t $(($pane + $count))
            tmux split-window -v
            ((count++))
        done
        host_count=$(($host_count / 2))
    done

    setopt sh_word_split
    tmux select-pane -t {top-left}
    for host in $host_list; do
        tmux send-keys "ssh $host" Enter
        tmux select-pane -t {next}
    done
    unsetopt sh_word_split

}
alias gl='git log --decorate --date=short --pretty=format:"%C(green)%cd - %C(red)%h%Creset - %C(auto)%d%C(reset) %s %C(bold blue)<%an>%Creset"'
alias gls='git log "$(git rev-parse --abbrev-ref --symbolic-full-name @{u})" --decorate --date=short --pretty=format:"%C(green)%cd - %C(red)%h%Creset - %C(auto)%d%C(reset) %s %C(bold blue)<%an>%Creset"'


export MPARAMS="sim_mode=1 bringup_flags_enable=1 bfe_cpu_queues_enable=0 bfe_config_pll=1 bfe_cpu_enable=0"
export MPARAMS="${MPARAMS} nic_ports_mask=0xffffff"
export MPARAMS="${MPARAMS} reset_on_lockup=1 timeout_locked=400 bfe_dram_enable=1 bfe_mmu_enable=1"
export MPARAMS="${MPARAMS} bfe_mme_mask=0 bfe_tpc_mask=0x0 bfe_rotator_mask=0x0 bfe_decoder_mask=0x0"
export MPARAMS="${MPARAMS} bfe_axi_drain=1 bfe_dram_scrambler_enable=0"
export MPARAMS="${MPARAMS} bfe_sram_scrambler_enable=0 bfe_security_enable=0"
export EXTRA_CMAKE_FLAGS="-DCMAKE_EXPORT_COMPILE_COMMANDS=true"
alias cmake="cmake ${EXTRA_CMAKE_FLAGS}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export BAT_CONFIG_PATH="/home/jschwarz/.batrc"

function hclmd5() {
    if [ -f /tmp/hcl.build_failed ]; then
        echo "Last build failed, you should run the build"
        return 1
    fi
    if [ ! -f /tmp/hcl.md5sum ]; then
        echo "No md5sum file, you should run the build"
        return 1
    fi

    old=$(cat /tmp/hcl.md5sum)
    new=$(find src tests -iname "*.cpp" -or -iname "*.h" | xargs md5sum | md5sum)
    python3 -c "if '$old'.split()[0] != '$new'.split()[0]: import sys;sys.exit(1)"

    if [[ $? -eq 0 ]]; then
        echo "No file changed, you should skip the build"
        return 0
    fi

    echo "md5sum is different, you should run the build"
    echo $new > /tmp/hcl.md5sum
    return 1
}

function build() {
    pushd $HCL_ROOT
    hclmd5
    retval=$?
    popd
    if [[ $retval -ne 0 ]]; then
        if build_synapse -l $1 && build_hcl $1; then
            pushd $HCL_ROOT
            new=$(find src tests -iname "*.cpp" -or -iname "*.h" | xargs md5sum | md5sum)
            popd
            echo $new > /tmp/hcl.md5sum
            rm /tmp/hcl.build_failed
            return 0
        else
            echo "BUILD FAILED"
            touch /tmp/hcl.build_failed
            return 1
        fi
    fi
}

export PATH=$PATH:$HOME/.local/bin/hlctl
