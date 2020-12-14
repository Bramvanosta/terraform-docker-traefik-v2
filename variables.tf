# Required variables
variable "hostname" {
  type        = string
  description = "Hostname for accessing Traefik e.g. traefik.example.com"
}

variable "acme_email" {
  type        = string
  description = "Let's Encrypt email address used for registration."
}

# Optional variables
variable "networks" {
  type        = list(string)
  description = "List of networks to connect Traefik to."
  default     = ["traefik"]
}

variable "traefik_network" {
  type        = string
  description = "Traefik (Docker overlay) network name."
  default     = "traefik"
}

variable "traefik_network_attachable" {
  type        = string
  description = "Make the default Traefik network attachable?"
  default     = false
}

variable "traefik_version" {
  type        = string
  description = "Traefik Docker image version."
  default     = "2.3.5" # https://github.com/traefik/traefik/releases/latest
}

variable "password" {
  type        = string
  description = "Password to login to Traefik dashboard (username: admin)"
  default     = "traefik"
}

variable "traefik_ssl_cert" {
  type        = string
  description = "The Let's Encrypt environment to use when requesting the SSL certificate for the Traefik instance: staging, production"
  default     = "staging" # Prevents hitting Let's Encrypts rate limit when testing.
  validation {
    condition     = length(regexall("^staging|production$", var.traefik_ssl_cert)) > 0
    error_message = "Let's Encrypt enviroment variable should be staging or production."
  }
}

variable "lets_encrypt_keytype" {
  type        = string
  description = "The SSL certificate key type Let's Encrypt issues: EC256, EC384, RSA2048, RSA4096, RSA8192"
  default     = "RSA4096"
  validation {
    condition     = length(regexall("^EC256|EC384|RSA2048|RSA4096|RSA8192$", var.lets_encrypt_keytype)) > 0
    error_message = "Invalid key type value. Valid Let's Encrypt key types are EC256, EC384, RSA2048, RSA4096, RSA8192."
  }
}

variable "lets_encrypt_resolvers" {
  type        = list(string)
  description = "A list of DNS Challange providers to enable in the Traefik configuration"
  default     = []
  validation {
    condition     = can([for provider in var.lets_encrypt_resolvers : regex("^cloudflare$", provider)])
    error_message = "Invalid/Unsupported DNS Provider listed. Supported values are: cloudflare."
  }
}

# Cloudflare DNS Variables
variable "cloudflare_dns_token" {
  type        = string
  description = "Cloudflare DNS Token"
  default     = ""
}

variable "cloudflare_zone_token" {
  type        = string
  description = "Cloudflare ZONE Token"
  default     = ""
}

variable "cloudflare_email" {
  type        = string
  description = "Cloudflare Account Email"
  default     = ""
}

variable "cloudflare_api_key" {
  type        = string
  description = "Cloudflare Global API Key"
  default     = ""
}