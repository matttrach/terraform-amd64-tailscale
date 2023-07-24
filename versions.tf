terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = ">= 0.13.5"
    }
  }
}
