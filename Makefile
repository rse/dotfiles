##
##  Makefile -- make(1) procedure
##

all:

install:
	cp dot.bash_login $$HOME/.bash_login
	cp dot.bashrc     $$HOME/.bashrc
	cp dot.inputrc    $$HOME/.inputrc
	cp dot.tmux.conf  $$HOME/.tmux.conf
	cp dot.vimrc      $$HOME/.vimrc

