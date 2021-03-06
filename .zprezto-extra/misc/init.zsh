#=============================================================================#
# Miscellaneous
#=============================================================================#

setopt dvorak     # I use a Dvorak keyboard :)
#export ASPELL_CONF="variety ize"   # Use Oxford English Dictionary spelling

# Load FZF config for ZSH
if [[ -d /usr/share/fzf ]]; then
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi
export FZF_DEFAULT_COMMAND='rg --files --hidden'
FZF_PREVIEW="[[ -f {} ]] && (bat --color=always {} || cat {}) 2> /dev/null"
export FZF_DEFAULT_OPTS="--border --preview '${FZF_PREVIEW}'"

# Bat
export BAT_THEME=OneHalfDark

# yarn
PATH=~/.yarn/bin:$PATH

# asdf
source "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

# ENV
PATH=$PATH:~/Tools
EDITOR=nvim
VISUAL=nvim

# Use Clang by default
#export CC="/usr/bin/clang"
#export CXX="/usr/bin/clang++"

# GPG needs this for pinentry_tty
export GPG_TTY=$(tty)

# Elixir / Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# Fix for Audacity PulseAudio support
export PULSE_LATENCY_MSEC=100

#=============================================================================#
# Aliases and convenience functions
#=============================================================================#

# Config - spawn a shell pointing git to the config repository
alias config="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME $SHELL"

# Vim
alias vim=nvim
alias ecx='edit-compressed-xml'

# Generic Docker
alias dc="docker-compose"
alias dcr="docker-compose run --rm"
alias dce="docker-compose exec"

# QGit
function qgit { /usr/bin/qgit $@ & }
alias qgita="qgit --all"

# Noise (for concentration)
# Valid parameters are: white, pink, brown; default is brown.
function noise {
  if [[ -z $1 ]]; then
    1="brown"
  fi
  play -Gqc2 -n synth ${1}noise remix 1,2p-18 2,1p-18 fade h 2
}

# Video
alias ffmpeg-check-interlace="ffmpeg -filter:v idet -an -f rawvideo -y /dev/null -i "

# Misc
alias wiki="cd ~/Nextcloud/Documents/Wiki/src && vim index.md"
alias wwiki="cd ~/Nextcloud/Documents/Wiki/src && vim work/index.md"
alias restart-plasma="kquitapp5 plasmashell && sleep 3 && kstart5 plasmashell"
alias kill-telepathy="ps -fA | egrep telepathy\\\\/ > >(cat) > >(awk '{ print \$2 }' | xargs -L1 kill)"
alias pacfiles="locate .pacnew; locate .pacsave; locate .pacorig"
alias oldlibs="sudo lsof +c 0 | grep -w DEL | awk '1 { print \$1 \": \" \$NF }' | sort -u"
alias music='ncmpcpp'

if (( $+commands[bat] )); then
  alias cat="bat --style=plain"
fi
# alias rgrep="/usr/bin/rg"  # I use an rg alias for Rails :p

alias sc="sudo systemctl"
alias scu="systemctl --user"
alias p="yay"
alias update="p -Syu"
