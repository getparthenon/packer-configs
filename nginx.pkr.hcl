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

source "docker" "ubuntu-base" {
  image = "getparthenon/ubuntu-ansible:21.04"

  commit = true
  changes = [
    "EXPOSE 9000",
    "ENTRYPOINT [\"/entrypoint.sh\"]"
  ]
}

build {
  name    = "ubuntu-nginx"
  sources = [
    "source.docker.ubuntu-base"
  ]

  provisioner "file" {
    source      = "./nginx/entrypoint.sh"
    destination = "entrypoint.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /entrypoint.sh"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "./nginx/playbook.yml"
  }
  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-nginx"
      tags       = ["21.04"]
      only       = ["docker.ubuntu-base"]
    }

    post-processor "docker-push" {}
  }
}
