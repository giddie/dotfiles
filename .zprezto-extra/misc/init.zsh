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
export FZF_DEFAULT_OPTS="--border --preview '${FZF_PREVIEW}' --bind ctrl-a:toggle-all --bind ctrl-p:toggle-preview"

# Bat
export BAT_THEME=ansi

# asdf

# asdf-erlang
export KERL_BUILD_DOCS=yes
export KERL_INSTALL_HTMLDOCS=no
export KERL_INSTALL_MANPAGES=no

# ENV
export XDG_DESKTOP_DIR=~/In
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

typeset -gU PATH path
if (( ! ${+DIRENV_DIR} )); then
  path=(
    $HOME/.local/bin
    $HOME/.asdf/shims
    $HOME/.yarn/bin
    $HOME/.cargo/bin
    $path
  )
fi

# direnv
eval "$(direnv hook zsh)"

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
alias e=nvim
alias ediff=nvimdiff
alias ecx='edit-compressed-xml'

# Docker
alias dc="docker compose"
alias dcu="docker compose up --build"
alias dcp="docker compose --profile"
alias dcr="docker compose run --rm"
alias dce="docker compose exec"

# QGit & Tig
function qgit { /usr/bin/qgit $@ & }
alias qgita="qgit --all"
alias tiga="tig --all"

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
alias beep="echo -e '\a'"
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
alias rsync_cp="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1"

if (( $+commands[bat] )); then
  alias cat="bat --style=plain"
fi

# System Updates
alias sc="sudo systemctl"
alias scu="systemctl --user"
alias p="yay"
alias update="p -Syu && flatpak update && flatpak remove --unused"
