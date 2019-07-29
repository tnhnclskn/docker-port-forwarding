# What is Port Forwarding?

In computer networking, port forwarding or port mapping is an application of network address translation (NAT) that redirects a communication request from one address and port number combination to another while the packets are traversing a network gateway, such as a router or firewall. This technique is most commonly used to make services on a host residing on a protected or masqueraded (internal) network available to hosts on the opposite side of the gateway (external network), by remapping the destination IP address and port number of the communication to an internal host.

## Docker Compose (Remote to Local & Local to Remote)

```bash
$ curl -sSL https://raw.githubusercontent.com/tnhnclskn/docker-port-forwarding/master/docker-compose.yml > docker-compose.yml
$ docker-compose up -d
```

# Prerequisites

To run this application you need Docker Engine 1.10.0. Docker Compose is recomended with a version 1.6.0 or later.

### Run the application using Docker Compose

This is the recommended way to run port-forwarding. You can use the following docker compose template:

```yaml
version: '2'
services:
  rtl-forwarding:
    image: tnhnclskn/port-forwarding
    ports:
      - 80:80
    volumes:
      - ~/.ssh:/root/.ssh
    environment:
      SRC_ADDR: nat-user.ip
      SRC_PORT: 80
      DST_ADDR: 0.0.0.0
      DST_PORT: 80
      SSH_USER: root
      SSH_ADDR: tunnel-server.ip
      SSH_PORT: 22
  ltr-forwarding:
    image: tnhnclskn/port-forwarding
    volumes:
      - ~/.ssh:/root/.ssh
    environment:
      SRC_ADDR: nat-user.ip
      SRC_PORT: 80
      DST_ADDR: 0.0.0.0
      DST_PORT: 80
      SSH_USER: root
      SSH_ADDR: remote-server.ip
      SSH_PORT: 22
      ROTATE: 'reverse'

```

### Run the application manually

If you want to run the application manually instead of using docker-compose, these are the basic steps you need to run:

1. Launch the container

  ```bash
  $ docker run -d --name port-forwarding -p 80:80 \
    -e SSH_ADDR=accessible-nat-server.ip \
    -e SRC_ADDR=source-nat-server.ip \
    --volume ~/.ssh:/root/.ssh \
    tnhnclskn/port-forwarding:latest

  $ docker run -d --name port-forwarding \
    -e SSH_ADDR=global-server.ip \
    -e SRC_ADDR=source-nat-server.ip \
    -e ROTATE=reverse \
    --volume ~/.ssh:/root/.ssh \
    tnhnclskn/port-forwarding:latest
  ```

Then you can access your port at running container address.

# Configuration

## Environment variables

When you start the port-forwarding image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the docker run command line.

##### Port Forwarding configuration

 - `SSH_ADDR`: Accessible SSH Server IP Address.
 - `SSH_PORT`: Accessible SSH Server Port Number. Default: **22**
 - `SSH_USER`: Accessible SSH Server User Name. Default: **root**
 - `SRC_ADDR`: Source Server IP Address on Accessible SSH Server's NAT.
 - `SRC_PORT`: Source Server Port Number on Accessible SSH Server's NAT. Default: **80**
 - `DST_ADDR`: Destination Server IP Address on Server. Default: **80**
 - `DST_PORT`: Destination Port Number on Server. Default: **80**
 - `ROTATE`: Port Forwarding Rotation(local/reverse). Default: **local**

If you want to add a new environment variable:

 * For docker-compose add the variable name and value under the application section:

```yaml
port-forwarding:
  image: tnhnclskn/port-forwarding:latest
  ports:
    - 80:80
  environment:
    - SSH_ADDR=accessible-nat-server.ip
    - SRC_ADDR=source-nat-server.ip
```

 * For manual execution add a `-e` option with each variable and value:

  ```bash
  $ docker run -d --name port-forwarding -p 80:80 \
    -e SSH_ADDR=Accessible-nat-server.ip \
    -e SRC_ADDR=source-nat-server.ip \
    tnhnclskn/port-forwarding:latest
  ```

# Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/tnhnclskn/docker-port-forwarding/issues), or submit a [pull request](https://github.com/tnhnclskn/docker-port-forwarding/pulls) with your contribution.

# Issues

- Host OS and version
- Docker version (`docker version`)
- Output of `docker info`
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)

# License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
