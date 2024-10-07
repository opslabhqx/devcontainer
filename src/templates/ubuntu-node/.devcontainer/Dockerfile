# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/devcontainer/ubuntu-node
ARG VARIANT=jammy@sha256:958a75d343d64b257c02602ba656a1dd052b1da9c964493421d8729af876f577

FROM public.ecr.aws/opslabhq/devcontainer/ubuntu-node:${VARIANT:-latest}

# [Optional] Uncomment this section to install additional OS packages.
# RUN $(which sudo) apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && $(which sudo) apt-get install -y --no-install-recommends <your-package-list-here>
