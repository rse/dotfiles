##
##  Makefile -- make(1) procedure
##

DESTDIR =
prefix  = /usr/local
bindir  = $(prefix)/bin
datadir = $(prefix)/share/dotfiles

all:

install:
	./shtool mkdir -f -p -m 755 $(DESTDIR)$(datadir)
	./shtool install -c -m 755 -e 's;@datadir@;$(datadir);g' dotfiles.sh $(DESTDIR)$(bindir)/dotfiles
	./shtool install -c -m 644 dot.bash_login $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.bash_login $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.bashrc     $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.inputrc    $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.tmux.conf  $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.vimrc      $(DESTDIR)$(datadir)
	./shtool install -c -m 644 dot.gitconfig  $(DESTDIR)$(datadir)

