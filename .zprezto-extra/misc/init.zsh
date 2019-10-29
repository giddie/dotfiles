#=============================================================================#
# Miscellaneous
#=============================================================================#

setopt dvorak     # I use a Dvorak keyboard :)
#export ASPELL_CONF="variety ize"   # Use Oxford English Dictionary spelling

# SSH Keychain
# NOTE: This is handled by zprezto now
# HOSTNAME=`hostname`
# keychain -Q -q ~/.ssh/id_dsa --agents ssh
# [[ -f $HOME/.keychain/$HOSTNAME-sh ]] && source $HOME/.keychain/$HOSTNAME-sh

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

# FZF
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'

# Use Clang by default
#export CC="/usr/bin/clang"
#export CXX="/usr/bin/clang++"

# GPG needs this for pinentry_tty
export GPG_TTY=$(tty)

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

# Elixir / Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

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

alias sc="sudo systemctl"
alias scu="systemctl --user"
alias p="yay"
alias update="p -Syu"

# Fix for Audacity PulseAudio support
export PULSE_LATENCY_MSEC=30
