variable "address" {
  type        = string
  description = "The address of the server to deploy on."
}

variable "user" {
  type        = string
  description = "The name of the user to login as."
}

variable "vs" {
  type        = string
  description = "the version number of tailscale to deploy"
  default     = "1.32.2_amd64"
}