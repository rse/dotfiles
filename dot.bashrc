##
##  ~/.bashrc -- bash(1) run-command script
##  Copyright (c) 1995-2019 Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##

#   enforce UTF-8 locale
export LC_CTYPE="en_US.UTF-8"

#   determine terminal colors
ps1_col_num=$(tput colors 2>/dev/null)
if [[ -n $ps1_col_num && $ps1_col_num -ge 8 ]]; then
    #   determine terminal color sequences
    ps1_col_bl=$(tput setaf 4)
    ps1_col_rd=$(tput setaf 1)
    ps1_col_no=$(tput sgr0)
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
export PAGER="less -r"
export PAGER_FLAGS="-r"
alias more="less -r"

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
HISTCONTROL="erasedups:ignoreboth"
PROMPT_COMMAND="history -a"

#   customize ls(1) command
ls () {
    case $OSTYPE in
        *freebsd* ) CLICOLOR_FORCE=1 command ls -k -q -G ${1+"$@"} | $PAGER -X -E ;;
        *linux*   ) command ls -k -q --color=always ${1+"$@"} | $PAGER -X -E ;;
        *         ) command ls ${1+"$@"} | $PAGER -X -E ;;
    esac
}
alias ll="ls -l"
alias la="ls -la"

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
    envrc switch -i "$HOME"
fi

#   optionally enable local settings
if [[ -f ~/.bash-local.rc ]]; then
    source ~/.bash-local.rc
fi

