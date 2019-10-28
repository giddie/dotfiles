# My Dotfiles

## Setup

```bash
git clone --bare --recursive https://github.com/giddie/dotfiles ~/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'

config config --local status.showUntrackedFiles no

config checkout
config submodule update --init --recursive
```

## Tracking files

To add  files to be tracked simply use the normal git commands via the alias.

```bash
config add .config/new-config-file
config add .new-dotfile-to-track
config commit -m 'Added new config files'
config push

```

To remove a file from being tracked and keep it locally use

```bash
config rm --cached .remove-this-dotfile
config push
```

I don't want README.md in my home directory. I can access it via Github/Gitlab
web interface. So inform git the file hasn't changed, then remove it locally.

```bash
config update-index --assume-unchanged README.md
rm README.md
```

Should I wish to undo this to edit the file (I normally edit via Github/Gitlab)
I can run the following:

```bash
config update-index --no-assume-unchanged README.md
config checkout README.md
config add  README.md
config commit -m 'Updated README.md'
config push
```
