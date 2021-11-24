
source "docker" "ubuntu-nginx" {
  image = "getparthenon/ubuntu-ansible:21.04"

  commit = true
  changes = [
    "EXPOSE 80",
    "ONBUILD RUN ln -sf /dev/stdout /var/log/nginx/access.log",
    "ONBUILD RUN ln -sf /dev/stderr /var/log/nginx/error.log",
    "ENTRYPOINT [\"/entrypoint.sh\"]"
  ]
}

build {
  name    = "ubuntu-nginx"
  sources = [
    "source.docker.ubuntu-nginx"
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
      only       = ["docker.ubuntu-nginx"]
    }

    post-processor "docker-push" {}
  }
}
