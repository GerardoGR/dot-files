# My dot files

## Install

Run the `./install.bash` script

## Update vim and tmux plugins

```bash
git submodule foreach 'git pull'

git add .tmux/plugins/ .vim/pack/
git commit -m "chore: update tmux and vim  plugins"
git push
```
