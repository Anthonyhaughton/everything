// Left off trying to figure out how to make a cert and add it to the CF distro. Because of validation it's kind of 
// scuffed. I ended up creating a cert in the console and then making this var to reference it and attach it to CF.


variable "acm_certificate" {
  type        = string
  default     = "arn:aws:acm:us-east-1:356031655355:certificate/601bd8b5-23a9-45db-bec6-6db5f2e24b34"
  description = "cert for SSL site."
}

variable dns_name {
  type        = string
  default     = "devhaughton.com"
  description = "Domain name for site."
}

variable region {
  type = string
  default = "us-east-1"
  description = "AWS Region."
}

variable cred_file {
  type = string
  default = "~/.aws/credentials"
  description = "Where the cred file is located."
}

variable profile {
  type = string
  default = "vscode"
  description = "Profile to use."
}