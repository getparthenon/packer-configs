packer {
  required_plugins {
    docker = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

variable "docker_login" {
  type    = string
  default = "${env("DOCKER_LOGIN")}"
}
variable "docker_token" {
  type    = string
  default = "${env("DOCKER_TOKEN")}"
}
