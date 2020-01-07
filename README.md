# My Dotfiles

## Setup

```bash
git clone --bare --recursive https://github.com/giddie/dotfiles ~/.dotfiles

alias config="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME $SHELL"

config
git config --local status.showUntrackedFiles no
git checkout
git submodule update --init --recursive
exit
```

## Tracking files

To add files to be tracked, invoke a subshell using the `config` alias, and use git as normal:

```bash
config
git add .config/new-config-file
git add .new-dotfile-to-track
git commit -m 'Added new config files'
git push
exit
```

To remove a file from being tracked and keep it locally use

```bash
git rm --cached .remove-this-dotfile
```

I don't want README.md in my home directory. I can access it via Github/Gitlab
web interface. So inform git the file hasn't changed, then remove it locally.

```bash
git update-index --assume-unchanged README.md
rm README.md
```

Should I wish to undo this to edit the file (I normally edit via Github/Gitlab),
I can run the following:

```bash
git update-index --no-assume-unchanged README.md
git checkout README.md
git add  README.md
git commit -m 'Updated README.md'
git push
```
