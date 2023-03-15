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

# asdf-direnv
if (( $+commands[asdf] )); then
  export DIRENV_LOG_FORMAT=""
  source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
fi

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
alias -g vim=nvim
alias -g vimdiff=nvimdiff
alias ecx='edit-compressed-xml'

# Generic Docker
alias dc="docker-compose"
alias dcp="docker-compose --profile"
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

# Restic
restic_nexcloud_env_file=~/Secrets/restic-nextcloud.env
if [[ -f $restic_nexcloud_env_file ]]; then
  # This is a wrapper to avoid the restic ENVs being exported to every process
  # the shell invokes.
  function restic {
    $SHELL -c "source $restic_nexcloud_env_file && /usr/bin/env restic $*"
  }
fi

# Misc
alias restart-plasma="kquitapp5 plasmashell && sleep 3 && kstart5 plasmashell"
alias kill-telepathy="ps -fA | egrep telepathy\\\\/ > >(cat) > >(awk '{ print \$2 }' | xargs -L1 kill)"
alias pacfiles="locate .pacnew; locate .pacorig"
alias oldlibs="sudo lsof +c 0 | grep -w DEL | awk '1 { print \$1 \": \" \$NF }' | sort -u"
alias music="ncmpcpp"
alias files="ranger"
alias projsplit="tmux split-window -h -l 71%"
alias projmain="tmux resize-pane -x 71%"
alias tmuxn="tmux new-session"
alias freedisk="sudo ~/Tools/lvm-pool-usage"
alias livebook="(sleep 2 && open http://localhost:31380) & docker run --rm -p 127.0.0.1:31380:8080 -p 127.0.0.1:31381:8081 -e LIVEBOOK_TOKEN_ENABLED=false --pull always -u $(id -u):$(id -g) -v ~/Nextcloud/Projects/Livebook:/data livebook/livebook"

if (( $+commands[bat] )); then
  alias cat="bat --style=plain"
fi

# System Updates
alias sc="sudo systemctl"
alias scu="systemctl --user"
alias p="yay"
alias update="p -Syu && flatpak update && flatpak remove --unused"
