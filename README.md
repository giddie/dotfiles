# My Dotfiles

## Setup

```bash
git clone --bare --recursive https://github.com/giddie/dotfiles ~/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'

config config --local status.showUntrackedFiles no

config checkout
config submodule update --init --recursive
```
