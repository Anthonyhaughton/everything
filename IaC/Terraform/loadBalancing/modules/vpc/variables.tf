variable "vpc_cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "CIDR for VPC."
}

variable "map_public_ip_on_launch" {
  type = string 
  default = "true"
  description = "Assoc IP on creation"
}

variable "environment" {
  type        = string
  description = "dev/test/prod"
  default     = "dev"
}

variable "project_name" {
  type = string
  description = "Project name for the tags"
  default = "project-alb"
}

variable "managed_by" {
  type = string
  description = "desc for tags"
  default = "terraform"
}

variable "subnet_object" {
  type = map(object({
    name              = string,
    cidr              = string,
    availability_zone = string
  }))
  default = {
    "subnet_a" = {
      name              = "us-east-1a",
      cidr              = "10.10.1.0/28"
      availability_zone = "us-east-1a"
    },
    "subnet_b" = {
      name              = "us-east-1b",
      cidr              = "10.10.2.0/28"
      availability_zone = "us-east-1b"
    },
    "subnet_c" = {
      name              = "us-east-1c",
      cidr              = "10.10.3.0/28"
      availability_zone = "us-east-1c"
    },
    "subnet_d" = {
      name              = "us-east-1d",
      cidr              = "10.10.4.0/28"
      availability_zone = "us-east-1d"
    }
  }
}

variable "az_number" {
  # Assign a number to each AZ letter used in our configuration
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
  }
}

