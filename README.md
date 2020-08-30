## ToolBox

### Prepare:
```bash
$ sudo apt-get install git make zsh tmux repo build-essential libncurses5-dev zlib1g-dev python libperl-dev libpython-dev libpython3-dev libx11-dev libxt-dev gawk
```
https://ftp.gnu.org/pub/gnu/global/
```bash
$ ./configure --prefix=$HOME/root/usr
$ make
$ make install
```

Copy repo

Copy .ssh

### Cmd:
* Clear environment setup, use ~/Workspace/ToolBox as default dir
* All setup
```bash
$ repo init -u git@github.com:wjxing/repo-ToolBox.git -g all --no-clone-bundle -m linux.xml
$ repo sync -c --no-clone-bundle --no-tags
$ repo start --all master

$ cd setup
$ ./allinone.sh
```

* Help, print support task
```bash
$ cd setup
$ ./allinone.sh -h
```

### Dir:
#### $TOOLBOX_HOME/bin
Origin bins

#### $TOOLBOX_HOME/setup
Setup scripts

#### $TOOLBOX_HOME/source
Third party tools

#### $TOOLBOX_HOME/vimplugin
Vim plugins

#### $TOOLBOX_HOME/root
Tool install dir
