# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/devcontainer/ubuntu-base
ARG VARIANT=jammy@sha256:c5355c0abfa5d37964303555fb8ff383adf140c818d3c7c6c7b6df1493b40d7b

FROM public.ecr.aws/opslabhq/devcontainer/ubuntu-base:${VARIANT:-latest}

# [Optional] Uncomment this section to install additional OS packages.
# RUN $(which sudo) apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && $(which sudo) apt-get install -y --no-install-recommends <your-package-list-here>
