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
    name="$1"
    desc="$2"
    if [ -f "$dstdir/.$name" ]; then
        if [ $force = no ]; then
            echo "dotfiles: ERROR: pre-existing \"$dstdir/.$name\" -- remove first (or use option --force)" 1>&2
            exit 1
        else
            if [ $quiet = no ]; then
                echo "dotfiles: pre-existing \"$dstdir/.$name\" -- preserved as \"$dstdir/.$name.old\"" 1>&2
            fi
            mv "$dstdir/.$name" "$dstdir/.$name.old"
        fi
    fi
    if [ $quiet = no ]; then
        echo "dotfiles: installing \"$dstdir/.$name\": $desc"
    fi
    cp "$srcdir/dot.$name" "$dstdir/.$name"
    chmod 644 "$dstdir/.$name"
}

#   install all dot files
installfile bash_login  "bash(1) login-hook script"
installfile bash_logout "bash(1) logout-hook script"
installfile bashrc      "bash(1) run-command script"
installfile inputrc     "bash(1) readline configuration"
installfile tmux.conf   "tmux(1) configuration"
installfile vimrc       "vim(1) configuration"
installfile gitconfig   "git(1) configuration"

