# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# Put your fun stuff here.

export PATH="$PATH:/home/jschwarz/bin"

alias grep='grep --color=auto'

alias fa='find . -name ".tox" -prune -o -name "tests" -prune -o -name ".git" -prune -o -name "*" -type f -print0 | xargs -0 grep -n --color=auto'
alias fp='find . -name ".tox" -prune -o -name "tests" -prune -o -name ".git" -prune -o -name "*.py" -type f -print0 | xargs -0 grep -n --color=auto'
alias fc='find . -name ".tox" -prune -o -name "tests" -prune -o -name ".git" -prune -o -name "*.[ch]" -type f -print0 | xargs -0 grep -n --color=auto'
alias fh='find /usr/include -name "*.h" -type f -print0 | xargs -0 grep -n --color=auto'

alias vi='vim'
alias duh='du -h -d 1'

export PS1='\[\e[1;36m\]\D{%T} \[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \$ \[\e[m\]'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=$PATH:~/.local/bin/

source ~/trees/npu-stack/automation/habana_scripts/habana_env
source ~/trees/npu-stack/gc_tools/hcl/hcl_aliases

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/libibverbs

alias gl='git log --decorate --date=short --pretty=format:"%C(green)%cd - %C(red)%h%Creset - %C(auto)%d%C(reset) %s %C(bold blue)<%an>%Creset"'
