#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_XTERM=${RUN_XTERM:-yes}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_XTERM in
  false|no|n|0)
    rm -f /app/conf.d/xterm.conf
    ;;
esac

if [ -f /app/main.sh ]; then
  supervisord -c /app/supervisord.conf
  # if main programm is given disable xterm regadless of environment variable
  rm -f /app/conf.d/xterm.conf
  exec /app/main.sh
else
  exec supervisord -n -c /app/supervisord.conf
fi
