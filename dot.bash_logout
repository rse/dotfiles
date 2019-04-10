##
##  ~/.bash_logout -- bash(1) logout run-command script
##  Copyright (c) 1995-2019 Ralf S. Engelschall <rse@engelschall.com>
##  Distributed under MIT <https://opensource.org/licenses/MIT> license.
##

#   increase privacy on outmost shell exit
if expr $- : ".*i.*" >/dev/null; then
    if [[ $SHLVL -eq 1 ]]; then
        clear
    fi
fi

