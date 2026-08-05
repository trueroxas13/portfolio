#!/bin/sh
cmd0() { echo -n "[$@-0]"; return 0; }
cmd1() { echo -n "[$@-1]"; return 1; }
second() { echo "[second]"; }

doit() { echo "case: $@"; eval "$@"; echo; }

doit 'cmd0 start && cmd0 first && second'
doit 'cmd0 start && cmd0 first || second'
doit 'cmd0 start || cmd0 first && second'
doit 'cmd0 start || cmd0 first || second'

doit 'cmd0 start && cmd1 first && second'
doit 'cmd0 start && cmd1 first || second'
doit 'cmd0 start || cmd1 first && second'
doit 'cmd0 start || cmd1 first || second'

doit 'cmd1 start && cmd0 first && second'
doit 'cmd1 start && cmd0 first || second'
doit 'cmd1 start || cmd0 first && second'
doit 'cmd1 start || cmd0 first || second'

doit 'cmd1 start && cmd1 first && second'
doit 'cmd1 start && cmd1 first || second'
doit 'cmd1 start || cmd1 first && second'
doit 'cmd1 start || cmd1 first || second'