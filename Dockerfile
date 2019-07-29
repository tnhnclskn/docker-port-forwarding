FROM alpine

MAINTAINER Tunahan Çalışkan <mail@tunahancaliskan.com>

ENV SSH_PORT=22
ENV SSH_USER=root

RUN apk add --no-cache autossh bash

WORKDIR /app
ADD forwarding.sh .

CMD ["bash", "forwarding.sh"]
