# My dot files

## Requirements

1. git

## Install

```bash
cd $HOME
git init
git remote add origin git@github.com:GerardoGR/dot-files.git
git pull
git checkout main
git submodule update --init --recursive
```

## Update vim and tmux plugins

```bash
git submodule foreach 'git pull'

git add .tmux/plugins/ .vim/pack/
git commit -m "chore: update tmux and vim  plugins"
git push
```
