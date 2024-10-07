# ubuntu-node

![Build status](https://github.com/opslabhqx/devcontainer/actions/workflows/build-push-ubuntu-node.yml/badge.svg)
![Licence: MIT](https://img.shields.io/github/license/opslabhqx/devcontainer)

## Description

`ubuntu-node` Docker image. It is maintained and published under the `opslabhq` Amazon ECR Public Gallery account.

[https://gallery.ecr.aws/opslabhq/devcontainer/ubuntu-node](https://gallery.ecr.aws/opslabhq/devcontainer/ubuntu-node)

## Docker Image

- **Image Name**: `ubuntu-node`
- **Group**: `devcontainer`
- **Docker Hub Username**: `opslabhq`
- **Supported Platforms**: `linux/amd64,linux/arm64`
- **Base Image**: `ubuntu`

## Tags

The Docker image is tagged as follows:

```
"public.ecr.aws/${OWNER}/${GROUP}/${FILE}",
"public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${TAG}",
"public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${BASE_VERSION}",
"public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${TAG}-${BASE_VERSION}",
```

## Usage

To pull and run the Docker image, use the following commands:

```bash
# Pull the image
docker pull public.ecr.aws/opslabhq/devcontainer/ubuntu-node:latest

# Run the image
docker run --name <container_name> -d public.ecr.aws/opslabhq/devcontainer/ubuntu-node:latest
```
