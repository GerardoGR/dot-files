# My dot files

## TODO

- [ ] Package installation: sudo pacman -S ttc-iosevka

## Requirments

1. Git
1. SSH Access to the git@github.com:GerardoGR/dot-files.git repo

## Install

```
cd $HOME

git clone --recurse-submodules git@github.com:GerardoGR/dot-files.git .dot-files

.dot-files/local-bin/dot-files-install.bash
```

## Pull latest changes

```bash
cd $HOME/.dot-files

git pull --recurse-submodules
```

## Update nvm, vim and tmux plugins

```bash
cd $HOME/.dot-files

git submodule foreach 'git pull'

git add tmux/plugins/ vim/pack/ nvm/
git commit -m "chore: update tmux, vim and nvm plugins"
git push
```

## Add vim plugin

```bash
cd $HOME/.dot-files

git submodule add -f $plugin_url vim/pack/plugins/start/$plugin_name
git commit -m "feat: new plugin $plugin_name"
git push
```
