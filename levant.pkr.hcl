
source "docker" "ubuntu-levant" {
  image = "getparthenon/ubuntu-ansible:20.04"

  commit = true
}

build {
  name    = "ubuntu-levant"
  sources = [
    "source.docker.ubuntu-levant"
  ]

  provisioner "ansible-local" {
    playbook_file = "./levant/playbook.yml"
  }


  provisioner "shell" {
    inline = [
      "curl -L https://github.com/hashicorp/levant/releases/download/0.3.0/linux-amd64-levant -o /levant",
      "chmod +x /levant"
    ]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/levant"
      tags       = ["latest"]
      only       = ["docker.ubuntu-levant"]
    }

    post-processor "docker-push" {}
  }
}
