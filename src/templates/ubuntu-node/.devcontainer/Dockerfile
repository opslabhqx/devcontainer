# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=opslabhq/devcontainer/ubuntu-node
ARG VARIANT=jammy@sha256:c6f613f439f3d31a40207547fe7055e4135be3d87395aa1044d3be8c6eec7321

FROM public.ecr.aws/opslabhq/devcontainer/ubuntu-node:${VARIANT:-latest}

# [Optional] Uncomment this section to install additional OS packages.
# RUN $(which sudo) apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && $(which sudo) apt-get install -y --no-install-recommends <your-package-list-here>
