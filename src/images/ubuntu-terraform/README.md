# ubuntu-terraform

![Build status](https://github.com/opslabhqx/devcontainer/actions/workflows/build-push-ubuntu-terraform.yml/badge.svg)
![Licence: MIT](https://img.shields.io/github/license/opslabhqx/devcontainer)

## Description

`ubuntu-terraform` Docker image. It is maintained and published under the `opslabhq` Amazon ECR Public Gallery account.

[https://gallery.ecr.aws/opslabhq/devcontainer/ubuntu-terraform](https://gallery.ecr.aws/opslabhq/devcontainer/ubuntu-terraform)

## Docker Image

- **Image Name**: `ubuntu-terraform`
- **Group**: `devcontainer`
- **Docker Hub Username**: `opslabhq`
- **Supported Platforms**: `linux/amd64,linux/arm64`
- **Base Image**: `ubuntu`

## Tags

The Docker image is tagged as follows:

```
${OWNER}/${GROUP}/${FILE}",
${OWNER}/${GROUP}/${FILE}:${TAG}",
${OWNER}/${GROUP}/${FILE}:${BASE_VERSION}",
${OWNER}/${GROUP}/${FILE}:${TAG}-${BASE_VERSION}",
```

## Usage

To pull and run the Docker image, use the following commands:

```bash
# Pull the image
docker pull public.ecr.aws/opslabhq/devcontainer/ubuntu-terraform:latest

# Run the image
docker run --name <container_name> -d public.ecr.aws/opslabhq/devcontainer/ubuntu-terraform:latest
```
