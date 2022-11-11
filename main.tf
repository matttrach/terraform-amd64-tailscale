locals {
  address = var.address
  user    = var.user
  version = var.vs
}

resource "null_resource" "deploy_tailscale" {
  connection {
    type        = "ssh"
    user        = local.user
    script_path = "/home/${local.user}/deploy_tailscale.sh"
    agent       = true
    host        = local.address
  }

  provisioner "file" {
    content     = file("${path.module}/install_tailscale.sh")
    destination = "/home/${local.user}/install_tailscale.sh"
  }

  provisioner "file" {
    content     = file("${path.module}/tailscale.defaults")
    destination = "/home/${local.user}/tailscale.defaults"
  }

  provisioner "file" {
    content     = file("${path.module}/tailscale.service")
    destination = "/home/${local.user}/tailscale.service"
  }

  provisioner "remote-exec" {
    inline = [<<-EOT
      sudo mv /home/${local.user}/tailscale.service /root/tailscale.service
      sudo mv /home/${local.user}/tailscale.defaults /root/tailscale.defaults
      sudo mv /home/${local.user}/install_tailscale.sh /root/install_tailscale.sh
      sudo chmod +x /root/install_tailscale.sh
    EOT
    ]
  }

  provisioner "remote-exec" {
    inline = [<<-EOT
      sudo /root/install_tailscale.sh ${local.version}
    EOT
    ]
  }
}
