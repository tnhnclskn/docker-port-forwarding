version: '3'

services:
  port-forwarding:
    image: tnhnclskn/port-forwarding
    ports:
      - 80:80
    volumes:
      - ~/.ssh:/root/.ssh
    environment:
      PUBLISH_PORT: 80
      SOURCE_ADRESS: nat-user.ip
      SOURCE_PORT: 80
      SSH_TUNNEL_USER: root
      SSH_TUNNEL_ADDRESS: tunnel-server.ip
      SSH_TUNNEL_PORT: 22
