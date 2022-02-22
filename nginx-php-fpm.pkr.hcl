
source "docker" "ubuntu-nginx-php-fpm" {
  image = "getparthenon/ubuntu-ansible:20.04"

  commit = true
  changes = [
    "EXPOSE 9000",
    "ONBUILD RUN ln -sf /dev/stdout /var/log/php8.1-fpm.log",
    "ENTRYPOINT [\"/entrypoint.sh\"]"
  ]
}

build {
  name = "nginx-php-fpm8.1"
  sources = [
    "source.docker.ubuntu-nginx-php-fpm"
  ]

  provisioner "file" {
    source      = "php-fpm8.1/entrypoint.sh"
    destination = "entrypoint.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /entrypoint.sh"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "./nginx-php-fpm8.1/playbook.yml"
  }

  provisioner "file" {
    source      = "./nginx-php-fpm8.1/configs/php-fpm/"
    destination = "/etc/php/8.1/fpm"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-nginx-php-fpm"
      tags       = ["8.1"]
      only       = ["docker.ubuntu-nginx-php-fpm"]
    }

    post-processor "docker-push" {
    }
  }
}
