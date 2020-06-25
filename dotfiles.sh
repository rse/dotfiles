#!/bin/sh
##
##  dotfiles -- Essential Unix Dot-Files
##  Copyright (c) 1995-2020 Dr. Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##
##  dotfiles: sh(1) based deployment utility
##

#   configuration
versionstr="@version@"
srcdir="@datadir@"

#   command-line argument parsing
usage () {
    echo "dotfiles: USAGE: dotfiles [-v|--version] [-q|--quiet] [-f|--force] [-p|--preserve] [-r|--remote <user>@<host>] <home-directory>" 1>&2
    echo "                 dotfiles -e [<file>...]" 1>&2
}
if [ $# -eq 0 ]; then
    usage
    exit 1
fi
version=no
quiet=no
force=no
preserve=no
remote=""
while [ $# -gt 0 ]; do
    case "$1" in
        -v|--version  ) version=yes;      shift ;;
        -q|--quiet    ) quiet=yes;        shift ;;
        -f|--force    ) force=yes;        shift ;;
        -p|--preserve ) preserve=yes;     shift ;;
        -e|--edit     ) edit=yes;         shift ;;
        -r|--remote   ) shift; remote=$1; shift ;;
        * ) break ;;
    esac
done
if [ $version = yes ]; then
    echo "$versionstr"
    exit 0
fi
if [ $edit = yes ]; then
    cd $HOME/.dotfiles
    exec ${EDITOR:-vi} ${*:-.}
    exit 0
fi
if [ $# -ne 1 ]; then
    echo "dotfiles: ERROR: invalid number of arguments $#" 1>&2
    usage
    exit 1
fi
dstdir="$1"

#   helper commands for changing target
target_exec () {
    if [ ".$remote" != . ]; then
        ssh -q "$remote" "$@"
    else
        "$@"
    fi
}
target_cp () {
    if [ ".$remote" != . ]; then
        scp -q "$1" "$remote:$2"
    else
        cp "$1" "$2"
    fi
}

#   install all dot files
installfile () {
    srcfile="$1"
    dstfile="$2"
    desc="$3"
    if target_exec test -f "$dstdir/$dstfile"; then
        if [ $force = no ]; then
            echo "dotfiles: ERROR: pre-existing \"$dstdir/$dstfile\" -- remove first (or use option --force)" 1>&2
            exit 1
        else
            if [ $preserve = yes ]; then
                if [ $quiet = no ]; then
                    echo "dotfiles: pre-existing \"$dstdir/$dstfile\" -- preserved as \"$dstdir/$dstfile.old\"" 1>&2
                fi
                target_exec mv "$dstdir/$dstfile" "$dstdir/$dstfile.old"
            else
                target_exec chmod 644 "$dstdir/$dstfile"
            fi
        fi
    fi
    if [ $quiet = no ]; then
        echo "dotfiles: installing \"$dstdir/$dstfile\": $desc"
    fi
    dstpath=`dirname "$dstdir/$dstfile"`
    if ! target_exec test -d "$dstpath"; then
        target_exec mkdir -p "$dstpath"
    fi
    target_cp "$srcdir/$srcfile" "$dstdir/$dstfile"
    target_exec chmod 444 "$dstdir/$dstfile"
}
installfile dot.bash_login  .bash_login  "bash(1) login-hook script"
installfile dot.bash_logout .bash_logout "bash(1) logout-hook script"
installfile dot.bashrc      .bashrc      "bash(1) run-command script"
installfile dot.inputrc     .inputrc     "bash(1) readline configuration"
installfile dot.tmux.conf   .tmux.conf   "tmux(1) configuration"
installfile dot.vimrc       .vimrc       "vim(1) configuration"
installfile dot.vifmrc      .vifm/vifmrc "vifm(1) configuration"
installfile dot.gitconfig   .gitconfig   "git(1) configuration"
installfile dot.sshconfig   .ssh/config  "ssh(1) configuration"

#   provide empty override files
tmpfile="${TMPDIR-/tmp}/dotfiles.tmp.$$"
rm -f $tmpfile
touch $tmpfile
provideempty () {
    dstfile="$1"
    desc="$2"
    if ! target_exec test -f "$dstdir/.dotfiles/$dstfile"; then
        if [ $quiet = no ]; then
            echo "dotfiles: providing empty \"$dstdir/.dotfiles/$dstfile\": $desc"
            target_cp $tmpfile "$dstdir/.dotfiles/$dstfile"
            target_exec chmod 644 "$dstdir/.dotfiles/$dstfile"
        fi
    fi
}
if ! target_exec test -d "$dstdir/.dotfiles"; then
    target_exec mkdir -p "$dstdir/.dotfiles"
fi
provideempty bashrc    "bash(1) run-command script override"
provideempty inputrc   "bash(1) readline configuration override"
provideempty tmux.conf "tmux(1) configuration override"
provideempty vimrc     "vim(1) configuration override"
provideempty vifmrc    "vifmrc(1) configuration override"
provideempty gitconfig "git(1) configuration override"
provideempty sshconfig "ssh(1) configuration override"
rm -f $tmpfile

