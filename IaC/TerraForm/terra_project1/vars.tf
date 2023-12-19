variable "availability_zones" {
  description = "AZs in this region to use"
  default     = ["us-east-1a", "us-east-1b"]
  type        = list(string)
}

variable "pub_sub_a_cidr" {
  default = "10.10.1.0/28"
}

variable "pub_sub_b_cidr" {
  default = "10.10.3.0/28"
}

variable "priv_sub_a_cidr" {
  default = "10.10.2.0/28"
}

variable "priv_sub_b_cidr" {
  default = "10.10.4.0/28"
}

variable "server_ami" {
  default = "ami-079db87dc4c10ac91"
}

# variable "subnet_cidrs_public" {
#   description = "Subnet CIDRs for public subnet"
#   default     = ["10.10.1.0/28", "10.10.3.0/28"]
#   type        = list(string)
# }