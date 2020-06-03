##
##  Makefile -- make(1) procedure
##  Copyright (c) 1995-2020 Dr. Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##

DESTDIR =
prefix  = /usr/local
bindir  = $(prefix)/bin
datadir = $(prefix)/share/dotfiles

all:

install:
	./shtool mkdir -f -p -m 755 $(DESTDIR)$(bindir)
	./shtool install -c -m 755 \
		-e "s;@version@;`cat VERSION.txt`;" \
		-e 's;@datadir@;$(datadir);g' \
		dotfiles.sh $(DESTDIR)$(bindir)/dotfiles
	./shtool mkdir -f -p -m 755 $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.bash_login  $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.bash_logout $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.bashrc      $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.inputrc     $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.tmux.conf   $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.vimrc       $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.vifmrc      $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.gitconfig   $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.sshconfig   $(DESTDIR)$(datadir)

