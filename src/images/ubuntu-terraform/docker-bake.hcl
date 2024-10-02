variable "OWNER" {
  default = "opslabhq"
}

variable "GROUP" {
  default = "devcontainer"
}

variable "FILE" {
  default = "ubuntu-terraform"
}

variable "TAG" {
  default = "latest"
}

variable "BASE_IMAGE" {
  default = "ubuntu"
}

variable "BASE_VERSION" {
  default = "latest"
}

group "default" {
  targets = ["build"]
}

target "settings" {
  context = "."
  cache-from = [
    "type=gha"
  ]
  cache-to = [
    "type=gha,mode=max"
  ]
}

target "test" {
  inherits = ["settings"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = []
}

target "build" {
  inherits = ["settings"]
  output   = ["type=docker"]
  tags = [
    "${OWNER}/${FILE}",
    "${OWNER}/${FILE}:${TAG}",
  ]
}

target "push" {
  inherits = ["settings"]
  output   = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = [
    "public.ecr.aws/${OWNER}/${GROUP}/${FILE}",
    "public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${TAG}",
    "public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${BASE_VERSION}",
    "public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${TAG}-${BASE_VERSION}",
  ]
}
