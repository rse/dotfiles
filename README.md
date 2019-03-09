
Essential Unix Dot-Files
========================

Abstract
--------

This is a very small collection of really essential Unix "dot-files" `~/.xxx`, i.e.,
opinionated configuration files for the shell environment of a Unix user, based
on the absolutely essential [GNU Bash](https://www.gnu.org/software/bash/) shell environment,
the [TMux](https://tmux.github.io/) terminal multiplexer, the file pager
[Less](http://www.greenwoodsoftware.com/less/), the
[Vim](http://www.vim.org/) file editor and the
[Git](https://git-scm.com/) distributed version control system. The intention is not an extensive
feature configuration, but the bare minimum of an opinionated pre-configuration.

Overview
--------

The particular "dot-files" are:

- [dot.bash_login](./dot.bash_login) (`~/.bash_login`): bash(1) login run-command script
- [dot.bashrc](./dot.bashrc) (`~/.bashrc`): bash(1) run-command script
- [dot.inputrc](./dot.inputrc) (`~/.inputrc`): bash(1) readline configuration
- [dot.tmux.conf](./dot.tmux.conf) (`~/.tmux.conf`): tmux(1) configuration
- [dot.vimrc](./dot.vimrc) (`~/.vimrc`): vim(1) configuration
- [dot.gitconfig](./dot.gitconfig) (`~/.gitconfig`): git(1) configuration

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

Copyright (c) 1995-2019 [Ralf S. Engelschall](mailto:rse@engelschall.com).<br/>
Distributed under [MIT](https://opensource.org/licenses/MIT) license.

