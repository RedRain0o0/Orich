# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# This prompt is a heavily modified version of https://github.com/ohmybash/oh-my-bash/tree/master/themes/lambda
# The prompt looks like this (given youre in a virtualenv setup with git)
# ╭─  virtualenv 󰣇 user@host ~/directory ( branch) -------  09:00:00 ─┤
# ╰─❯ echo Hello, world!


# Prompt Customization
icon_start="╭─ "
icon_distro="󰣇 "
icon_host="@"
icon_venv=" "
icon_directory=" "
icon_branch=""
icon_time="  \t ─┤" #╮
icon_end="╰─❯ "

# Fix for VENV from https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt
virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($icon_venv$venv) "
}
VIRTUAL_ENV_DISABLE_PROMPT=1
VENV="\$(virtualenv_info)";

# Spacers + Time
PS1='\[$(printf "%*s" $(($(tput cols)-14)) "" | sed "s/ /-/g")'$icon_time'\r'
# Header + VENV
PS1+=$icon_start${VENV}
# Distro and user@host
PS1+=$icon_distro$_omb_prompt_bold_brown'\u'$_omb_prompt_normal$icon_host$_omb_prompt_bold_teal'\h'
# Directory
PS1+=$_omb_prompt_normal$icon_directory$_omb_prompt_bold_purple'\w '
# Git branch
PS1+=$_omb_prompt_normal$(__git_ps1 "("$icon_branch" %s) ")
# Footer
PS1+='\n'$icon_end
PS2=$icon_end

#function cd {
#  builtin cd "$@" && ls -a --color=auto'
#}

# Alias's and Startup Command
fastfetch
alias nf='clear; fastfetch'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ..='cd ..'
