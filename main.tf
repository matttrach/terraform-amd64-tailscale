locals {
  address = var.address
  user    = var.user
  version = var.vs
}

resource "tailscale_tailnet_key" "key" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
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
    content     = file("${path.module}/tailscaled.defaults")
    destination = "/home/${local.user}/tailscaled.defaults"
  }

  provisioner "file" {
    content     = file("${path.module}/tailscaled.service")
    destination = "/home/${local.user}/tailscaled.service"
  }

  provisioner "remote-exec" {
    inline = [<<-EOT
      sudo mv /home/${local.user}/tailscaled.service /root/tailscaled.service
      sudo mv /home/${local.user}/tailscaled.defaults /root/tailscaled.defaults
      sudo mv /home/${local.user}/install_tailscale.sh /root/install_tailscale.sh
      sudo chmod +x /root/install_tailscale.sh
    EOT
    ]
  }

  provisioner "remote-exec" {
    inline = [<<-EOT
      sudo /root/install_tailscale.sh ${local.version} ${tailscale_tailnet_key.key.key}
    EOT
    ]
  }
}
