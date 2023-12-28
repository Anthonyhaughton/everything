variable "environment" {
  type        = string
  description = "dev/test/prod"
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range for the VPC"
  default     = "10.10.0.0/16"
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




# variable "public_subnet_azs" {
#     type = map(number)
#     description = "Map of AZ to a number that should be used for public subnets"

#     default = {
#         "us-west-1a" = 1
#         "us-west-1b" = 2
#         "us-west-1c" = 3
#         "us-west-1d" = 4
#     }
# }

# variable "public_subnet_cidrs" {
#     type = map(number)
#     description = "Map of cidrs to a number that should be used for public subnets"

#     default = {
#         "10.0.1.0/28" = 1
#         "10.0.2.0/28" = 2
#         "10.0.3.0/28" = 3
#         "10.0.4.0/28" = 4
#     }
# }