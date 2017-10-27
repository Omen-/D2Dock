# D2Dock
Dockerized version of Dofus 2 game client.

## Requirements

If you are on Linux you should install

- [docker](http://docs.docker.com/compose/install/#install-docker)

If you are running on [Mac OS](https://docs.docker.com/engine/installation/mac/) or [Windows](https://docs.docker.com/engine/installation/windows/).

## Usage

The idea is to extend this container to add your automation program (something like a MITM bot or anything else that uses the Dofus client).

If you have no idea how to do this you can take a look at the Docker [get started](https://docs.docker.com/get-started/).

## VNC Server

A vnc server is shipped this container to let you monitor the client. The password is `1234` by default.
