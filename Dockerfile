FROM ubuntu:20.04

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

RUN apt-get install -y --no-install-recommends \
    curl fakeroot ca-certificates

WORKDIR /app

USER docker