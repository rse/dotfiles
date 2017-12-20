
Ralf S. Engelschall's Unix Dot-Files
====================================

This is a very small collection of really essential Unix "dot-files" `~/.xxx`, i.e.,
opinionated configuration files for the shell environment of a Unix user, based
on the absolutely essential [GNU Bash](https://www.gnu.org/software/bash/) shell environment,
the [TMux](https://tmux.github.io/) terminal multiplexer, the file pager
[Less](http://www.greenwoodsoftware.com/less/) and the
[Vim](http://www.vim.org/) file editor. The intention is not an extensive
feature configuration, but the bare minimum of an opinionated pre-configuration.

The particular "dot-files" are:

- [dot.bash_login](./dot.bash_login): (`~/.bash_login`)<br/>
  bash(1) login run-command script

- [dot.bashrc](./dot.bashrc): (`~/.bashrc`)<br/>
  bash(1) run-command script

- [dot.inputrc](./dot.inputrc): (`~/.inputrc`)<br/>
  bash(1) readline configuration

- [dot.tmux.conf](./dot.tmux.conf): (`~/.tmux.conf`)<br/>
  tmux(1) configuration

- [dot.vimrc](./dot.vimrc): (`~/.vimrc`)<br/>
  vim(1) configuration

Hint: In practice this should be combinated with my [bash-fzf](https://github.com/rse/bash-fzf)
scripts which further enhance the GNU Bash shell environment with the excellent FZF searching utility.

Copyright (c) 1995-2017 [Ralf S. Engelschall](mailto:rse@engelschall.com).<br/>
Distributed under [MIT](https://opensource.org/licenses/MIT) license.

