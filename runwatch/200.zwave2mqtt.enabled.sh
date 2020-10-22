#!/usr/bin/env ash

BINARY="node"
PARAMS="bin/www"

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
    exit 0
    ;;

start)
    echo "Starting... $BINARY $PARAMS"
    if [ "${SOCAT_ZWAVE_HOST}" != "" ]; then
        echo "Checking socat..."
        SOCATCHECK=`pgrep -f "socat"`
        if [ "${SOCATCHECK}" = "" ] >/dev/null 2>&1 ; then
            echo "##### socat is not running, skipping start of Zwave2Mqtt"
            exit 1
        fi
    fi

    # Everything is running, start Zwave2Mqtt
    cd /usr/src/app

    $BINARY $PARAMS &
    exit 0

    ;;

start-fail)
    echo "Start failed! $BINARY $PARAMS"
    ;;

stop)
    echo "Stopping... $BINARY $PARAMS"
    cd /usr/src/app
    kill -9 $(pgrep -f "$BINARY $PARAMS")
    ;;

esac
