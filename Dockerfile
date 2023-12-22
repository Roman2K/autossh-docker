FROM alpine

ENV \
  TERM=xterm                  \
  AUTOSSH_LOGFILE=/dev/stdout \
  AUTOSSH_GATETIME=30         \
  AUTOSSH_POLL=10             \
  AUTOSSH_FIRST_POLL=30       \
  AUTOSSH_LOGLEVEL=1

RUN apk update
RUN apk add --no-cache --update bash autossh openssh-client

RUN addgroup -g 1000 -S app \
  && adduser -u 1000 -S app -G app

USER app
WORKDIR /home/app
RUN mkdir -m 0500 .ssh
COPY docker-entrypoint ./

STOPSIGNAL INT
ENTRYPOINT ["./docker-entrypoint"]
