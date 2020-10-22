#!/usr/bin/env ash

if [[ -z "${SOCAT_ZWAVE_TYPE}" ]]; then
  SOCAT_ZWAVE_TYPE="tcp"
fi

# No socat host/port set? Then do not complain and just exit.
if [[ -z "${SOCAT_ZWAVE_HOST}" ]]; then
  exit 1
fi
if [[ -z "${SOCAT_ZWAVE_PORT}" ]]; then
  exit 1
fi

BINARY="/usr/bin/socat"
PARAMS="-d pty,link=/dev/ttyACM0,raw,user=root,mode=777 $SOCAT_ZWAVE_TYPE:$SOCAT_ZWAVE_HOST:$SOCAT_ZWAVE_PORT"

######################################################

CMD=$1

case $CMD in

describe)
    echo "Sleep $PARAMS"
    ;;

## exit 0 = is not running
## exit 1 = is running
is-running)
    if pgrep -f "$BINARY $PARAMS" >/dev/null 2>&1 ; then
        exit 1
    fi
    # stop Zwave2Mqtt if socat is not running 
    if pgrep -f "node bin/www" >/dev/null 2>&1 ; then
        echo "stopping Zave2Mqtt since socat is not running"
        kill -9 $(pgrep -f "node bin/www")
    fi
    exit 0
    ;;

start)
    echo "Starting... $BINARY $PARAMS" 
    $BINARY $PARAMS &
    # delay other checks for 5 seconds
    sleep 5
    ;;

start-fail)
    echo "Start failed! $BINARY $PARAMS"
    ;;

stop)
    echo "Stopping... $BINARY $PARAMS"
    kill -9 $(pgrep -f "$BINARY $PARAMS")
    ;;

esac
