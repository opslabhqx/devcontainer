# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/ubuntu
ARG BASE_VERSION=jammy@sha256:94e15368d1096010be908266372abdd9568ef255cde2401c358491fcea4092bb

FROM opslabhq/ubuntu:${BASE_VERSION} AS base

LABEL maintainer="Anthony Yung <yhs88a@gmail.com>" \
    org.opencontainers.image.source="https://github.com/opslabhqx/docker-images"

RUN case `uname -m` in \
    x86_64) ARCH=x86_64; ;; \
    aarch64) ARCH=aarch64; ;; \
    *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac \
    && echo $ARCH > /tmp/ARCH \
    && cat /tmp/ARCH

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends sudo git curl ca-certificates build-essential zsh nano

FROM base AS build

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends unzip

RUN export ARCH=$(cat /tmp/ARCH) \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

FROM base AS final

COPY --from=build /usr/local/aws-cli /usr/local/aws-cli

RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws \
    && ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer \
    && ln -s $(which aws) /usr/local/bin/aws-cli

RUN chmod +x /usr/local/bin/*

ARG USER=default
ENV HOME=/home/$USER

RUN adduser --disabled-password --gecos "" $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
    && passwd $USER -d \
    && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

RUN touch ~/.bashrc \
    && echo "HISTFILE=~/.bash_history" >> ~/.bashrc \
    && echo "HISTSIZE=10000" >> ~/.bashrc \
    && echo "HISTFILESIZE=10000" >> ~/.bashrc \
    && echo "shopt -s histappend" >> ~/.bashrc \
    && echo 'PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> ~/.bashrc \
    && touch ~/.bash_history \
    && chmod 600 ~/.bash_history

RUN touch ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions \
    && echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting \
    && echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc \
    && echo "HISTFILE=~/.zsh_history" >> ~/.zshrc \
    && echo "HISTSIZE=10000" >> ~/.zshrc \
    && echo "SAVEHIST=10000" >> ~/.zshrc \
    && echo "setopt INC_APPEND_HISTORY" >> ~/.zshrc \
    && echo "setopt SHARE_HISTORY" >> ~/.zshrc \
    && touch ~/.zsh_history \
    && chmod 600 ~/.zsh_history
