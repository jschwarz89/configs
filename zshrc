if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify shwordsplit
unsetopt autocd beep extendedglob incappendhistory equals
bindkey -v

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(common-aliases macos ssh-agent zsh-autosuggestions)
#source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

export PATH="/usr/lib/ccache:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/local/sbin:/usr/sbin:/home/jschwarz/.cargo/bin:/home/jschwarz/.local/bin:/usr/local/go/bin:/home/jschwarz/go/bin:$HOME/.local/bin/hlctl:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Private stuff :)
export PATH="$PATH:/home/jschwarz/configs/powerline.git/scripts/:/home/jschwarz/configs/ccls/Release"
export GREP_COLOR="mt=1;31"

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

unset LC_CTYPE

export SVN_EDITOR="nvim"

export LANG=en_US.UTF-8

alias git-review="git-review -r origin"
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

alias vi='nvim -O'
alias vim="nvim -O"

alias gl='git log --decorate --date=short --pretty=format:"%C(green)%cd - %C(red)%h%Creset - %C(auto)%d%C(reset) %s %C(bold blue)<%an>%Creset"'
alias gls='git log "$(git rev-parse --abbrev-ref --symbolic-full-name @{u})" --decorate --date=short --pretty=format:"%C(green)%cd - %C(red)%h%Creset - %C(auto)%d%C(reset) %s %C(bold blue)<%an>%Creset"'

export EXTRA_CMAKE_FLAGS="-DCMAKE_EXPORT_COMPILE_COMMANDS=true -DCMAKE_COLOR_DIAGNOSTICS=ON"
alias cmake="cmake ${EXTRA_CMAKE_FLAGS}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GO111MODULE=on

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
