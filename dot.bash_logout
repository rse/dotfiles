##
##  dotfiles -- Essential Unix Dot-Files
##  Copyright (c) 1995-2020 Dr. Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##
##  ~/.bash_logout: bash(1) logout run-command script
##

#   increase privacy on outmost shell exit
if expr $- : ".*i.*" >/dev/null; then
    if [[ $SHLVL -eq 1 ]]; then
        clear
    fi
fi

