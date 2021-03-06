# Most of this was taken from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
setopt prompt_subst

function repo_path {
	echo "$(vcprompt -f %p)"
}

# Determine what character to use in place of the '$' for my prompt.
function repo_char {
    git branch >/dev/null 2>/dev/null && echo "%{$fg_bold[blue]%}$(repo_path)%{$reset_color%} »" && return
    echo '%~ $'
}

# Display any virtual env stuff with python.
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# All of my git variables.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# I like a new line between my result and the next prompt.  Makes it easier to see
PROMPT='
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)$(repo_char) '

# Display the date.  (My desktop at work uses $(date -u ...) instead, because I use UTC a lot at work.
RPROMPT='$(date "+%x %T %Z")'
