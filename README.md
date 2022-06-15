# My dot files

## TODO

- [ ] Document assuming sudo is setup

## Requirments

1. Git
1. SSH Access to the git@github.com:GerardoGR/dot-files.git repo

## Install for the first time

```
cd $HOME

git clone --recurse-submodules git@github.com:GerardoGR/dot-files.git .dot-files

.dot-files/local-bin/install-paru.bash
.dot-files/local-bin/install-missing-packages.bash
.dot-files/local-bin/dot-files-install.bash
```

## Pull latest changes

```bash
cd $HOME/.dot-files

git pull --recurse-submodules
```

## Upgrade vim or tmux plugins

```bash
cd $HOME/.dot-files

for p in $(git submodule | awk '/vim/ {print $2}'); do (cd $p && git checkout master || git checkout main; git pull); done
# or
# for p in $(git submodule | awk '/tmux/ {print $2}'); do (cd $p && git checkout master || git checkout main; git pull); done

git add vim
git commit -m "chore: upgrade vim plugins"
git push
```

## Add vim plugin

```bash
cd $HOME/.dot-files

git submodule add -f $plugin_url vim/pack/plugins/start/$plugin_name
git commit -m "feat: new plugin $plugin_name"
git push
```
