# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/ubuntu
ARG BASE_VERSION=noble@sha256:62bfaa962e2d1cf616a4d5bd68c394ee07395b355f3c37674b7ea0d84347eeb7

FROM opslabhq/ubuntu:${BASE_VERSION:-latest} AS base

LABEL maintainer="Anthony Yung <yhs88a@gmail.com>" \
    org.opencontainers.image.source="https://github.com/opslabhqx/docker-images"

RUN case `uname -m` in \
    x86_64) ARCH=x64; ;; \
    aarch64) ARCH=arm64; ;; \
    *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac \
    && echo $ARCH > /tmp/ARCH \
    && cat /tmp/ARCH

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends sudo git curl ca-certificates

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000
ARG HOME=/home/$USER
ENV HOME=/home/$USER \
    SHELL=/bin/bash

RUN if [ -d "/home/ubuntu" ]; then userdel -f ubuntu; fi \
    && groupadd --gid $PRIMARY_GROUP_ID $USER \
    && useradd --system --uid $USER_ID --gid $PRIMARY_GROUP_ID -m $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && passwd -d $USER

# renovate: datasource=github-tags depName=nodejs/node
ARG IMAGE_VERSION=v22.9.0

RUN export ARCH=$(cat /tmp/ARCH) \
    && curl -fsSL https://nodejs.org/dist/$IMAGE_VERSION/node-$IMAGE_VERSION-linux-$ARCH.tar.gz | tar -xzvf - --strip-components=1 -C /usr/local \
    && npm install -g pnpm

RUN git config --system --add safe.directory '*'

FROM base AS final

USER root
