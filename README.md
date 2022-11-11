# AMD64 Tailscale

This module installs Tailscale on any amd64 linux server which uses systemd.

## Requirements

### Nix

This module assumes you have the Nix package manager ~= 2.10 installed on your workstation.
This module uses Nix to configure your local environment with all required software.
This module uses Nix Flakes, which is an extra command to install (on top of Nix).

### Environment File

This module contains an .envrc which Nix will call to request user specific data for the environment.
The .envrc should be idempotent and specifying environment variables before hand should make it a no-op.

### Local State

The specific use case for the modules here is temporary infrastructure for testing purposes.
With that in mind it is not expected that the user will manage the resources as a team,
  therefore the state files are all stored locally.
If you would like to store the state files remotely, add a terraform backend file (`*.name.tfbackend`) to your implementation module.
https://www.terraform.io/language/settings/backends/configuration#file
