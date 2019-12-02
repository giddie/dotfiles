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

# rbenv
PATH=~/.rbenv/bin:~/.gem/ruby/2.6.0/bin:$PATH
eval "$(rbenv init - --no-rehash)"
(rbenv rehash &) 2> /dev/null

# Rust
PATH=~/.cargo/bin:$PATH

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
export PULSE_LATENCY_MSEC=30

#=============================================================================#
# Aliases and convenience functions
#=============================================================================#

# Config
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Vim
function gvim-remote {
  if (($# == 0)); then
    gvim $@
  else
    gvim --remote-silent $@
  fi
}
alias vim=nvim
alias ecx='edit-compressed-xml'

# Shortcuts for Rails Development
alias r="rails"
alias rg="rails g"
alias rs="rails s -b 0.0.0.0"
alias rc="rails c"
alias rdb="rails db -p"
alias be="bundle exec"
function rdev {
  daemons=(php-fpm postgresql)
  case $1 in
    "start")
      for daemon in $daemons; do
        sudo systemctl start $daemon.service
      done
      ;;
    "stop")
      for daemon in `echo $daemons | tac -s' '`; do
        sudo systemctl stop $daemon.service
      done
      ;;
    *)
      echo "Usage: $0 {start|stop}"
      ;;
  esac
}

# SSH
alias homerouter="ssh home.giddie.ddns.me.uk"

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
alias work-vpn="sudo openvpn --config ~/Work/vpn-config.ovpn"
alias restart-plasma="kquitapp5 plasmashell && sleep 3 && kstart5 plasmashell"
alias kill-telepathy="ps -fA | egrep telepathy\\\\/ > >(cat) > >(awk '{ print \$2 }' | xargs -L1 kill)"
alias pacfiles="locate .pacnew; locate .pacsave; locate .pacorig"
alias oldlibs="sudo lsof +c 0 | grep -w DEL | awk '1 { print \$1 \": \" \$NF }' | sort -u"
alias music='ncmpcpp'

if (( $+commands[bat] )); then
  alias cat="bat --plain"
fi
alias rgrep="/usr/bin/rg"  # I use an rg alias for Rails :p

alias sc="sudo systemctl"
alias scu="systemctl --user"
alias p="yay"
alias update="p -Syu"
