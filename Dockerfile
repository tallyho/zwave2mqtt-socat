FROM robertslando/zwave2mqtt:latest

RUN apk add socat

# Install runwatch
RUN mkdir /runwatch
COPY runwatch/* /runwatch/

WORKDIR /runwatch
CMD ["/bin/ash", "/runwatch/run.sh"]
