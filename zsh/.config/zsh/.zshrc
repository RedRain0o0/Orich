## Setup
source <(fzf --zsh)

# String sourced from https://www.reddit.com/r/unixporn/comments/1p3cybq/comment/nq6hoet
katakana="゠ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶ・ーヽヾヿ"
pipes="c│╭?╮╯─╮??╰│╯╰?╭─"

## Custom Comands
remindMeHowToMakeADesktopFile() {
    echo Run nano ~/.local/share/applications/[appName].desktop
    echo
    echo Contents:
    echo \[Desktop Entry\]
    echo Type=Application
    echo Name=NAME-OF-APPIMAGE
    echo Icon=/PATH/OF/ICON
    echo Exec=/PATH/OF/AppImage
    echo Terminal=false
    echo Hidden=false
    echo Categories=Utility
}

countMyMonsterAddiction() {
    oldCount=$(< ~/.monsters.txt)
    newCount=$(($oldCount + 1))
    echo $newCount > ~/.monsters.txt
    echo You\'ve downed $newCount White Monster Energies!
}

## Prompt
fg_red="%F{#FF999B}"
bg_red="%K{#FF999B}"
fg_white="%F{15}"
fg_grey="%F{253}"
bg_grey="%K{253}"
fg_black="%F{235}"
icon_host="@"
icon_directory="" # Make sure to include a space after the icon
icon_input="❯"
newline=$'\n'

PROMPT="${fg_red}%k${bg_red}${fg_white}%n%f%k${bg_red}${fg_white}${icon_host}%f%k${bg_red}${fg_white}%m%f%k${bg_grey}${fg_red} \
%f%k${bg_grey}${fg_black}${icon_directory}%~%f%k${fg_grey}\
%f${newline}${icon_input} "

# Alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias nf='clear; fastfetch'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sysup='yay; flatpak upgrade'
alias bashup='source ~/.config/zsh/.zshrc'
alias lst='trash-list'
alias cls='clear; echo'
alias gs='git status --short'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --all --graph --pretty=format:"%C(#FF999B)%C(255 #FF999B)%h%C(#FF999B 253) %C(235)%an (%ar)%C(253 default)%C(auto) %D%n%s%n"'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'
alias gf='onefetch'
alias timer='tty-countdown -m'
alias clock='tty-clock -s -c -n -D -C 0 -b'
alias desktop='remindMeHowToMakeADesktopFile'
alias runserver='java -Xmx2G -jar server.jar nogui'
alias avenv='source .venv/bin/activate'
alias dvenv='deactivate'
alias cvenv='python3 -m venv .venv'
alias v='nvim'
alias d='dolphin .'
alias rain='terminal-rain'
alias monster='countMyMonsterAddiction'
alias tmi='tmuxifier load-session'
alias tma='tmux attach -t'
cd() { builtin cd "$@" && ls -a --color=auto; }
# mkdir() { mkdir "$@" && builtin cd "$@"; }
stow() { stow -t ~ "$@"; }
rm() { trash "$@"; }
ytdl() { yt-dlp -x --audio-format mp3 "$@"; }
unimatrix() { command unimatrix -c green -u $katakana -s 95 "$@"; }
pipes() { command pipes.sh -t $pipes "$@"; }
stars() { astroterm --color --constellations -s 100 "$@"; }

openfff() {
    fff <$TTY
    zle redisplay
}
zle -N openfff
bindkey '^f' openfff

export EDITOR="nvim"
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

