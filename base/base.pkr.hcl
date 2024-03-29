packer {
  required_plugins {
    docker = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "raw-base" {
  image  = "ubuntu:20.04"
  commit = true
}
variable "docker_login" {
  type    = string
  default = "${env("DOCKER_LOGIN")}"
}
variable "docker_token" {
  type    = string
  default = "${env("DOCKER_TOKEN")}"
}

build {
  name = "ubuntu-base"
  sources = [
    "source.docker.raw-base"
  ]

  provisioner "shell" {
    inline = [
      "export DEBIAN_FRONTEND=\"noninteractive\"",
      "apt update",
      "apt upgrade -y",
      "apt install -y ansible bzip2 ca-certificates curl gcc gnupg gzip iproute2 procps python3 sudo tar unzip xz-utils zip bash"]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-ansible"
      tags       = ["20.04"]
      only       = ["docker.raw-base"]
    }

    post-processor "docker-push" {
      login = true
      login_username = "${var.docker_login}"
      login_password = "${var.docker_token}"
    }
  }
}
