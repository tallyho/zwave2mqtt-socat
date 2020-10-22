# zwave2mqtt-socat
zwave2mqtt with socat enabled for easy remote zwave publishing.

This is just a simple extension to zwave2mqtt that embeds a socat client internally that provides the zwave serial device.
If the socat connection goes down, it kills zwave2mqtt. Once socat can be re-established, zwave2mqtt is restarted.

## Build

docker build -f Dockerfile .

## Install

In addition to following the guide at, https://github.com/OpenZWave/Zwave2Mqtt/tree/master/docker. Set these environment variables:
1. SOCAT_ZWAVE_TYPE - any type socat supports, usually tcp
2. SOCAT_ZWAVE_HOST - the ip, like 127.0.0.1
3. SOCAT_ZWAVE_PORT - the port, like 3333
