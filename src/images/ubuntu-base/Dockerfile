# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/ubuntu
ARG BASE_VERSION=jammy@sha256:8c83c14285cd0502eb72ded73ac9902081a60b13d3c8f7c1d608d6442540c1ca

FROM opslabhq/ubuntu:${BASE_VERSION:-latest} AS base

LABEL maintainer="Anthony Yung <yhs88a@gmail.com>" \
    org.opencontainers.image.source="https://github.com/opslabhqx/docker-images"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends sudo git curl ca-certificates

RUN git config --system --add safe.directory '*'

FROM base AS final

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000
ENV HOME=/home/$USER \
    SHELL=/bin/bash

RUN addgroup --gid $PRIMARY_GROUP_ID $USER \
    && adduser --system --uid $USER_ID --ingroup $USER $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && passwd -d $USER

USER root
