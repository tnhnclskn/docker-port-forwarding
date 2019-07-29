FROM alpine

MAINTAINER Tunahan Çalışkan <mail@tunahancaliskan.com>

ENV SSH_PORT=22
ENV SSH_USER=root
ENV SRC_ADDR=localhost
ENV SRC_PORT=80
ENV DST_PORT=80

RUN apk add --no-cache autossh bash

WORKDIR /app
ADD forwarding.sh .

CMD ["bash", "forwarding.sh"]
