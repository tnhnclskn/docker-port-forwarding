FROM debian

MAINTAINER Tunahan Çalışkan <mail@tunahancaliskan.com>

ENV PUBLISH_PORT=80
ENV SOURCE_ADRESS=localhost
ENV SOURCE_PORT=80
ENV SSH_TUNNEL_USER=root
ENV SSH_TUNNEL_ADDRESS=localhost
ENV SSH_TUNNEL_PORT=22


RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install openssh-client -y
RUN apt-get install autossh -y

CMD autossh -N -L \
    0.0.0.0:$PUBLISH_PORT:$SOURCE_ADRESS:$SOURCE_PORT \
    $SSH_TUNNEL_USER@$SSH_TUNNEL_ADDRESS \
    -p$SSH_TUNNEL_PORT \
    -o ExitOnForwardFailure=yes \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3
