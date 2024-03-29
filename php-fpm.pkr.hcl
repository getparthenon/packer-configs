
source "docker" "ubuntu-php-fpm" {
  image = "getparthenon/ubuntu-ansible:20.04"

  commit = true
  changes = [
    "EXPOSE 9000",
    "ONBUILD RUN ln -sf /dev/stdout /var/log/php8.1-fpm.log",
    "ENTRYPOINT [\"/entrypoint.sh\"]"
  ]
}

build {
  name = "php-fpm8.0"
  sources = [
    "source.docker.ubuntu-php-fpm"
  ]

  provisioner "file" {
    source      = "php-fpm8.0/entrypoint.sh"
    destination = "entrypoint.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /entrypoint.sh"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "./php-fpm8.0/playbook.yml"
  }

  provisioner "file" {
    source      = "./php-fpm8.0/configs/php-fpm/"
    destination = "/etc/php/8.0/fpm"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-php-fpm"
      tags       = ["8.0"]
      only       = ["docker.ubuntu-php-fpm"]
    }

    post-processor "docker-push" {
      login = true
      login_username = "${var.docker_login}"
      login_password = "${var.docker_token}"
    }
  }
}

build {
  name = "php-fpm8.1"
  sources = [
    "source.docker.ubuntu-php-fpm"
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
    playbook_file = "./php-fpm8.1/playbook.yml"
  }

  provisioner "file" {
    source      = "./php-fpm8.1/configs/php-fpm/"
    destination = "/etc/php/8.1/fpm"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-php-fpm"
      tags       = ["8.1"]
      only       = ["docker.ubuntu-php-fpm"]
    }

    post-processor "docker-push" {
      login = true
      login_username = "${var.docker_login}"
      login_password = "${var.docker_token}"
    }
  }
}

build {
  name = "php-fpm8.2"
  sources = [
    "source.docker.ubuntu-php-fpm"
  ]

  provisioner "file" {
    source      = "php-fpm8.2/entrypoint.sh"
    destination = "entrypoint.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /entrypoint.sh"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "./php-fpm8.2/playbook.yml"
  }

  provisioner "file" {
    source      = "./php-fpm8.2/configs/php-fpm/"
    destination = "/etc/php/8.2/fpm"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "getparthenon/ubuntu-php-fpm"
      tags       = ["8.2"]
      only       = ["docker.ubuntu-php-fpm"]
    }

    post-processor "docker-push" {
      login = true
      login_username = "${var.docker_login}"
      login_password = "${var.docker_token}"
    }
  }
}
