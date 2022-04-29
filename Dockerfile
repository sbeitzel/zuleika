# syntax=docker/dockerfile:1

FROM ubuntu:latest

ENV TZ="America/Los_Angeles"
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gcc ghostscript git \
 make pkg-config libfreetype-dev libfreetype6 libpangocairo-1.0-0 \
 libpdf-api2-perl

WORKDIR /zuleika

RUN git clone https://github.com/lewdlime/abcm2ps.git

WORKDIR /zuleika/abcm2ps

RUN ./configure && make && make install

WORKDIR /zuleika

RUN rm -rf *

RUN apt-get remove -y curl gcc

RUN rm -rf /var/lib/apt/lists/*

LABEL maintainer="sbeitzel@pobox.com"
