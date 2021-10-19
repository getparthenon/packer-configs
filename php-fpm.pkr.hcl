
source "docker" "ubuntu-fpm-fpm" {
  image = "getparthenon/ubuntu-ansible:21.04"

  commit = true
  changes = [
    "EXPOSE 9000",
    "ENTRYPOINT [\"/entrypoint.sh\"]"
  ]
}

build {
  name = "php-fpm"
  sources = [
    "source.docker.ubuntu-fpm-fpm"
  ]

  provisioner "file" {
    source      = "php-fpm/entrypoint.sh"
    destination = "entrypoint.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /entrypoint.sh"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "./php-fpm/playbook.yml"
  }

  provisioner "file" {
    source      = "./php-fpm/configs/php-fpm/"
    destination = "/etc/php/8.0/fpm"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-php-fpm"
      tags       = ["8.0"]
      only       = ["docker.ubuntu-fpm-fpm"]
    }

    post-processor "docker-push" {
    }
  }
}