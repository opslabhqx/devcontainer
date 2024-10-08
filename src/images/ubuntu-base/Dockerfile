# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/ubuntu
ARG BASE_VERSION=noble@sha256:747dd8bec4903adb56b37abcc0b3e1c4ebb8eaeac136242ea282641c424ffac7

FROM opslabhq/ubuntu:${BASE_VERSION:-latest} AS base

LABEL maintainer="Anthony Yung <yhs88a@gmail.com>" \
    org.opencontainers.image.source="https://github.com/opslabhqx/docker-images"

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

RUN git config --system --add safe.directory '*'

FROM base AS final

USER root
