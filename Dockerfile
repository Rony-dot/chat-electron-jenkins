FROM ubuntu:20.04

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    curl fakeroot
