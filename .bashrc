# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# String sourced from https://www.reddit.com/r/unixporn/comments/1p3cybq/comment/nq6hoet
katakana="゠ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶ・ーヽヾヿ"

# Get git-prompt from https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
. ~/.git-prompt.sh



# This prompt is a heavily modified version of https://github.com/ohmybash/oh-my-bash/tree/master/themes/lambda
# The prompt looks like this (given youre in a virtualenv setup with git)
# ╭─  virtualenv 󰣇 user@host ~/directory ( branch) -------  09:00:00 ─┤
# ╰─❯ echo Hello, world!

# Colors
color_reset=\\[\\033[0m\\]
color_purple_bold=\\[\\033[01\;35m\\]
color_green_bold=\\[\\033[01\;32m\\]
color_teal_bold=\\[\\033[01\;96m\\]
color_red_bold=\\[\\033[01\;31m\\]
color_darkgray=\\[\\033[01\;90m\\]

# Prompt Customization
icon_tlbar="╭─"
icon_blbar="╰─"
icon_trbar="─┤"
icon_distro="󰣇"
icon_host="@"
icon_venv=""
icon_directory="" # Make sure to include a space after the icon
icon_branch=""
icon_time=""
icon_input="❯"

# Fix for VENV from https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt
virtualenv_info() {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($icon_venv' '$venv) "
}
VIRTUAL_ENV_DISABLE_PROMPT=1
VENV="\$(virtualenv_info)";

# ts doesnt work :wilted_rose:
cursor_color() {
    if [[ "$?" -gt 0 ]]; then
        echo -e 'a'
    else
        echo -e 'b'
    fi
}

# Spacers + Time
PS1=$color_darkgray'\[$(printf "%*s" $(($(tput cols)-14)) "" | sed "s/ /-/g") '$icon_time' \t '$color_reset$icon_trbar'\r'
# Header + VENV
PS1+=$icon_tlbar' '${VENV}
# Distro and user@host
PS1+=$icon_distro' '$color_red_bold'\u'$color_reset$icon_host$color_teal_bold'\h'
# Directory
PS1+=$color_reset' '$icon_directory$color_purple_bold'\w '
# Git branch
PS1+=$color_reset'$(__git_ps1 "("$icon_branch" %s) ")'
# Footer
PS1+='\n'$icon_blbar$icon_input' '
# Continuation
PS2=$icon_blbar$icon_input' '



# Alias's and Startup Command
cd() { builtin cd "$@" && ls -a --color=auto; }
fastfetch
alias nf='clear; fastfetch'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias lst='trash-list'
alias cls='clear'
rm() { trash "$@"; }
ytdl() { yt-dlp -x --audio-format mp3 "$@"; }
unimatrix() { command unimatrix -c green -u $katakana -s 95 "$@"; }
