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
plugins=(adb common-aliases osx ssh-agent sudo)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/local/sbin:/usr/sbin:/home/jschwarz/bin:/home/jschwarz/.local/bin:/home/jschwarz/bin:/home/jschwarz/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 #if [[ -n $SSH_CONNECTION ]]; then
   #export EDITOR='vim'
 #else
   #export EDITOR='xvim'
 #fi

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
export PATH="$PATH:/home/jschwarz/bin:/opt/local/bin"
export GREP_COLOR="1;31"

alias -g vim="vimx"
alias -g grep='grep --color=auto'

alias -g fa='find . -name ".tox" -prune -o -name "tests" -prune -o -name ".git" -prune -o -name "*" -type f -print0 | xargs -0 grep -n --color=auto'
alias -g fp='find . -name ".tox" -prune -o -name "tests" -prune -o -name ".git" -prune -o -name "*.py" -type f -print0 | xargs -0 grep -n --color=auto'
alias -g fpa='find . -name ".tox" -prune -o -name ".git" -prune -o -name "*.py" -type f -print0 | xargs -0 grep -n --color=auto'
alias -g fc='find . -name ".tox" -prune -o -name "tests" -prune -o -name ".git" -prune -o -name "*.[ch]" -type f -print0 | xargs -0 grep -n --color=auto'
alias -g fh='find /usr/include -name "*.h" -type f -print0 | xargs -0 grep -n --color=auto'

alias -g gitlog='git --no-pager log --pretty=oneline -n'

alias -g vi='vim'
alias -g duh='du -h -d 1'

alias -g rm='rm -f'
alias -g mv='mv -f'
alias -g cp='cp -f'

alias -g zeus02='console -M conserver-01.eng.tlv.redhat.com zeus02.eng.lab.tlv.redhat.com -l jschwarz'

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
unset LC_CTYPE

