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

# Spacers + Time
PS1='\[$(printf "%*s" $(($(tput cols)-14)) "" | sed "s/ /-/g")'$icon_time'\r'
# Header + VENV
PS1+=$icon_start$icon_venv$(_omb_prompt_print_python_venv)" "
# Distro and user@host
PS1+=$icon_distro$_omb_prompt_bold_brown'\u'$_omb_prompt_normal$icon_host$_omb_prompt_bold_teal'\h'
# Directory
PS1+=$_omb_prompt_normal$icon_directory$_omb_prompt_bold_purple'\w '
# Git branch
PS1+=$_omb_prompt_normal"("$icon_branch$(__git_ps1 " %s) ")
# Footer
PS1+='\n'$icon_end
PS2=$icon_end

# Alias's and Startup Command
fastfetch
alias nf='clear; fastfetch'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
