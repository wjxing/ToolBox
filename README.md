## ToolBox

### Cmd:
* Clear environment setup, use ~/Workspace/ToolBox as default dir
```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/wjxing/ToolBox/master/allinone.sh)"
```

* Custom default dir
```bash
$ TOOLBOX_HOME=/path/to/set/dir bash -c "$(curl -fsSL https://raw.githubusercontent.com/wjxing/ToolBox/master/allinone.sh)"
```

* Module setup

Not update repos, only setup all tools
```bash
$ cd tools/setup
$ ./allinone.sh -u disable
```

Not update repos, only setup special tools
```bash
$ cd tools/setup
$ ./allinone.sh -u disable -tsetup_bd -tsetup_crash ...
```

Only update repos
```bash
$ cd tools/setup
$ ./allinone.sh -u only
```

### Dir:
#### $TOOLBOX_HOME/tools/bin
Origin bins

#### $TOOLBOX_HOME/tools/setup
Setup scripts

#### $TOOLBOX_HOME/tools/source
Third party tools

#### $TOOLBOX_HOME/vimplugin
Vim plugins

#### $TOOLBOX_HOME/root
Tool install dir
