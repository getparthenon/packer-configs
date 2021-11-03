
source "docker" "ubuntu-levant" {
  image = "getparthenon/ubuntu-ansible:21.04"

  commit = true
}

build {
  name    = "ubuntu-levant"
  sources = [
    "source.docker.ubuntu-levant"
  ]

  provisioner "shell" {
    inline = [
      "curl -L https://github.com/hashicorp/levant/releases/download/0.2.9/linux-amd64-levant -o /levant",
      "chmod +x /levant"
    ]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/levant"
      tags       = ["21.04"]
      only       = ["docker.ubuntu-levant"]
    }

    post-processor "docker-push" {}
  }
}
