function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

local return_code="%(?.. %{$fg_bold[red]%}%?%{$reset_color%})"

PROMPT='%{$fg_bold[cyan]%}%*%{$reset_color%} %(!.%{$fg_bold[red]%}%n.%{$fg_bold[green]%}%n) %{$fg_bold[blue]%}%(!.%1~.%~)$return_code%{$reset_color%} $(prompt_char)%{$reset_color%} '
RPS1='$(git_prompt_info)%_%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}(%{$fg_bold[green]%}% "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}) "
