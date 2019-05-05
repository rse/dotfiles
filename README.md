
Essential Unix Dot-Files
========================

Abstract
--------

This is a small collection of really essential Unix "dot-files"
(`~/.xxx`), i.e., opinionated configuration files for the Unix shell
environments of Ralf S. Engelschall under FreeBSD, Linux and macOS. This
Unix environment is based on the following absolutely essential tools:

- the [GNU Bash](https://www.gnu.org/software/bash/) shell environment
- the [TMux](https://tmux.github.io/) terminal multiplexer
- the [Less](http://www.greenwoodsoftware.com/less/) file pager
- the [Vim](https://www.vim.org/) file editor
- the [Vifm](https://vifm.info/) file manager
- the [Git](https://git-scm.com/) version control system
- the [OpenSSH](https://www.openssh.com/) remote access facility

The intention of these "dot-files" is not to be an extensive tool
feature configuration, but to be the bare minimum of an opinionated tool
standard configuration.

Overview
--------

The particular Unix "dot-files" are:

- [dot.bash_login](./dot.bash_login) (`~/.bash_login`): bash(1) login run-command script
- [dot.bash_logout](./dot.bash_logout) (`~/.bash_logout`): bash(1) logout run-command script
- [dot.bashrc](./dot.bashrc) (`~/.bashrc`): bash(1) run-command script
- [dot.inputrc](./dot.inputrc) (`~/.inputrc`): bash(1) readline configuration
- [dot.tmux.conf](./dot.tmux.conf) (`~/.tmux.conf`): tmux(1) configuration
- [dot.vimrc](./dot.vimrc) (`~/.vimrc`): vim(1) configuration
- [dot.vifmrc](./dot.vifmrc) (`~/.vifm/vifmrc`): vifm(1) configuration
- [dot.gitconfig](./dot.gitconfig) (`~/.gitconfig`): git(1) configuration
- [dot.sshconfig](./dot.sshconfig) (`~/.ssh/config`): ssh(1) configuration

Installation
------------

You can install the package into your system with:

```
$ make install [DESTDIR=<dir>] [prefix=<dir>] [bindir=<dir>] [datadir=<dir>]
```

You can install the "dot-files" into the home-directory `<dir>` of an
account (either locally or remotely via SSH) with:

```
$ dotfiles [-q|--quiet] [-f|--force] [-p|--preserve] [-r|--remote <user>@<host>] <dir>
```

Additionally, ensure that the essential Unix commands bash(1), tmux(1),
less(1), vim(1), vifm(1) and git(1) are available in `$PATH` of the
using account. If not, install them into your system with your preferred
Unix software packaging mechanism:

- Debian/Ubuntu [Apt]:<br/>
  `$ apt-get install bash tmux less vim vifm git openssh-client`

- FreeBSD [pkg]:<br/>
  `$ pkg install bash tmux less vim vifm git openssh-portable`

- macOS [MacPorts]:<br/>
  `$ port install bash tmux less vim vifm git openssh`

- Unix [OpenPKG]:<br/>
  `$ openpkg build bash tmux less vim vifm git openssh | sh`

Local Override Configurations
-----------------------------

You can easily override the configuration with the following optional
files (which are automatically included and pre-generated):

- `~/.dotfiles/bashrc`    (for overriding `~/.bashrc`)
- `~/.dotfiles/inputrc`   (for overriding `~/.inputrc`)
- `~/.dotfiles/tmux.conf` (for overriding `~/.tmux.conf`)
- `~/.dotfiles/vimrc`     (for overriding `~/.vimrc`)
- `~/.dotfiles/vifmrc`    (for overriding `~/.vifm/vifmrc`)
- `~/.dotfiles/gitconfig` (for overriding `~/.gitconfig`)
- `~/.dotfiles/sshconfig` (for overriding `~/.ssh/config`)

Hint
----

In practice, this optimally should be combined with my [bash-fzf](https://github.com/rse/bash-fzf)
script which further enhances the GNU Bash shell environment with the excellent FZF searching functionality.
For this, just copy the [bash-fzf.rc](https://github.com/rse/bash-fzf/blob/master/bash-fzf.rc) script
to `~/.bash-fzf.rc` and ensure that the [FZF](https://github.com/junegunn/fzf/) utility is in your `$PATH`, too.

Similarly, this optimally can also be combined with my [bash-envrc](https://github.com/rse/bash-envrc)
script which further enhances the GNU Bash shell environment with the possibility to automatically
activate environment variables through the execution of (explicitly to be whitelisted) `.envrc` run-command scripts.
For this, just copy the [bash-envrc.rc](https://github.com/rse/bash-envrc/blob/master/bash-envrc.rc) script
to `~/.bash-envrc.rc`.

License
-------

Copyright (c) 1995-2019 [Dr. Ralf S. Engelschall](mailto:rse@engelschall.com).<br/>
Distributed under [MIT](https://opensource.org/licenses/MIT) license.

