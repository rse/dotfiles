##
##  dotfiles -- Essential Unix Dot-Files
##  Copyright (c) 1995-2019 Dr. Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##
##  ~/.bashrc: bash(1) run-command script
##

#   enforce UTF-8 locale
export LC_CTYPE="en_US.UTF-8"

#   determine terminal colors
term_colors=$(tput colors 2>/dev/null)
if [[ -n $term_colors && $term_colors -ge 8 ]]; then
    #   determine terminal color sequences
    ps1_col_bl=$'\e[34m'
    ps1_col_rd=$'\e[31m'
    ps1_col_no=$'\e[0m'
else
    #   fallback to no coloring
    ps1_col_bl=""
    ps1_col_rd=""
    ps1_col_no=""
fi

#   customize interactive prompt
shopt -s promptvars
PROMPT_DIRTRIM=11
PS1="${ps1_col_bl}\\u@\\h${ps1_col_no}:${ps1_col_rd}\${PWD}${ps1_col_no}\n\\\$ "
PS2="> "

#   perform shell window size checking
if expr $- : ".*i.*" >/dev/null; then
    shopt -s checkwinsize
fi

#   customize editor/pager handling
export EDITOR=vim
export PAGER="less"
export PAGER_FLAGS=""
alias more="less"

#   locate temporary directory
for __tmpdir in "$HOME/tmp" /tmp /var/tmp; do
    if [[ -d "$__tmpdir" && -w "$__tmpdir" ]]; then
        TMPDIR="$__tmpdir"
        break
    fi
done
unset __tmpdir

#   customize filesystem handling
umask 022
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s no_empty_cmd_completion
shopt -s checkhash
shopt -s globstar
alias -- +="cd +"
alias -- -="cd -"
alias -- ..="cd .."

#   customize history management
shopt -s cmdhist
shopt -s histappend
shopt -s lithist
HISTSIZE=1000
HISTFILESIZE=1000
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
HISTCONTROL="erasedups:ignoredups:ignorespace"
PROMPT_COMMAND="history -a"

#   customize ls(1) command
ls_options=""
ls_pager="$PAGER -X -E"
case $OSTYPE in
    *freebsd* ) ls_options="$ls_options -k -q" ;;
    *linux*   ) ls_options="$ls_options -k -q" ;;
esac
if [[ -n $term_colors && $term_colors -ge 8 ]]; then
    case $OSTYPE in
        *freebsd* )
            export LSCOLORS="ExcxcxcxbxcxcxbxbxExEx"
            export CLICOLOR_FORCE=1
            ls_options="$ls_options -G"
            ls_pager="$ls_pager -r"
            ;;
        *linux* )
            export LS_COLORS="no=00:fi=00:rs=00:di=01;34:ln=00;32:mh=00;32:or=37;42:mi=37;42:pi=00;32:so=00;32:do=00;32:bd=00;32:cd=00;32:su=00;31:sg=00;31:ex=00;31:ca=00:tw=00:ow=00:st=00:"
            ls_options="$ls_options --color=always"
            ls_pager="$ls_pager -r"
            ;;
    esac
fi
ls () {
    ls_options_extra=""
    case $OSTYPE in
        *freebsd* ) ls_options_extra="-C" ;;
        *linux*   ) ls_options_extra="-C" ;;
    esac
    command ls $ls_options $ls_options_extra ${1+"$@"} | $ls_pager
}
ll () {
    command ls $ls_options -l ${1+"$@"} | $ls_pager
}
la () {
    command ls $ls_options -l -a ${1+"$@"} | $ls_pager
}

#   provide tmux(1) wrapper command
tmux-session () {
    if [[ $# -ge 1 ]]; then
        session="$1"
        shift
    else
        session=default
    fi
    tmux new-session -A -s "$session" "$@"
}

#   determine reasonable search paths
__mkpath () {
    eval "unset $1"
    for __dir in $2; do
        [[ ${__dir: -1} != / ]] && __dir="$__dir/"
        for __subdir in $3; do
            if [[ -d "$__dir$__subdir" ]]; then
                eval "$1=\"\$$1\${$1+:}$__dir$__subdir\""
            fi
        done
    done
    eval "export $1"
}
__mkpath PATH    "$HOME /opt/local /opt /usr/opkg /usr/local            /usr /" "bin sbin"
__mkpath MANPATH "$HOME /opt/local /opt /usr/opkg /usr/local /usr/share /usr  " "man"
unset __mkpath

#   optionally enable FZF integration
if [[ -f ~/.bash-fzf.rc ]]; then
    source ~/.bash-fzf.rc
fi

#   optionally enable ENVRC functionality
if [[ -f ~/.bash-envrc.rc ]]; then
    source ~/.bash-envrc.rc
    if type -t envrc >/dev/null; then
        envrc switch -i "$HOME"
    fi
fi

#   include optional local configuration
if [[ -f ~/.dotfiles/bashrc ]]; then
    source ~/.dotfiles/bashrc
fi

