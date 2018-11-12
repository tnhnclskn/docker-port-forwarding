FROM debian

MAINTAINER Tunahan Çalışkan <mail@tunahancaliskan.com>

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install openssh-client -y
RUN apt-get install autossh -y

CMD autossh -N -L 0.0.0.0:$PUBLISH_PORT:$SOURCE_ADRESS:$SOURCE_PORT $SOURCE_SSH_USER@$SOURCE_SSH_ADDRESS -p$SOURCE_SSH_PORT  -o ExitOnForwardFailure=yes -o ServerAliveInterval=30 -o ServerAliveCountMax=3
