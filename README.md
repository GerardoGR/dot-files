# My dot files

## Install

Run `dot-files-install.bash` script

## Update vim and tmux plugins

```bash
git submodule foreach 'git pull'

git add .tmux/plugins/ .vim/pack/
git commit -m "chore: update tmux and vim  plugins"
git push
```

## Add vim plugin

```bash
git submodule add -f <plugin_url> .vim/pack/plugins/start/$plugin_name
git commit -m "feat: new plugin $plugin_name"
git push
```
