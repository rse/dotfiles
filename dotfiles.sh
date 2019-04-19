#!/bin/sh
##
##  dotfiles -- Essential Unix Dot-Files
##  Copyright (c) 1995-2019 Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##

#   configuration
srcdir="@datadir@"

#   command-line argument parsing
usage () {
    echo "dotfiles: USAGE: dotfiles [-f|--force] [-q|--quiet] <directory>" 1>&2
}
if [ $# -eq 0 ]; then
    echo "dotfiles: ERROR: invalid number of arguments" 1>&2
    usage
    exit 1
fi
force=no
quiet=no
while [ $# -gt 0 ]; do
    case "$1" in
        -f|--force ) force=yes; shift ;;
        -q|--quiet ) quiet=yes; shift ;;
        * ) break ;;
    esac
done
if [ $# -ne 1 ]; then
    echo "dotfiles: ERROR: invalid number of arguments" 1>&2
    usage
    exit 1
fi
dstdir="$1"

#   helper command
installfile () {
    srcfile="$1"
    dstfile="$2"
    desc="$3"
    if [ -f "$dstdir/$dstfile" ]; then
        if [ $force = no ]; then
            echo "dotfiles: ERROR: pre-existing \"$dstdir/$dstfile\" -- remove first (or use option --force)" 1>&2
            exit 1
        else
            if [ $quiet = no ]; then
                echo "dotfiles: pre-existing \"$dstdir/$dstfile\" -- preserved as \"$dstdir/$dstfile.old\"" 1>&2
            fi
            mv "$dstdir/$dstfile" "$dstdir/$dstfile.old"
        fi
    fi
    if [ $quiet = no ]; then
        echo "dotfiles: installing \"$dstdir/$dstfile\": $desc"
    fi
    dstpath="$dstdir/$dstfile"
    if [ ! -d "$dstpath" ]; then
        mkdir -p "$dstpath"
    fi
    cp "$srcdir/$srcfile" "$dstdir/$dstfile"
    chmod 644 "$dstdir/$dstfile"
}

#   install all dot files
installfile dot.bash_login  .bash_login  "bash(1) login-hook script"
installfile dot.bash_logout .bash_logout "bash(1) logout-hook script"
installfile dot.bashrc      .bashrc      "bash(1) run-command script"
installfile dot.inputrc     .inputrc     "bash(1) readline configuration"
installfile dot.tmux.conf   .tmux.conf   "tmux(1) configuration"
installfile dot.vimrc       .vimrc       "vim(1) configuration"
installfile dot.vifmrc      .vifm/vifmrc "vifm(1) configuration"
installfile dot.gitconfig   .gitconfig   "git(1) configuration"

