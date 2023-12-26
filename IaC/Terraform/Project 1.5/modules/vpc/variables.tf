# variable "env" {
#     type = string
#     description = "dev"
# }

variable "vpc_cidr" {
    type = string
    description = "The IP range for the VPC"
    default = "10.0.0.0/16"
}


// the "type = map" line allows you to assoc a string with a number. This also works in hand with the for_each func.

variable "public_subnet_numbers" {
    type = map(number)
    description = "Map of AZ to a number that should be used for public subnets"

    default = {
        "us-east-1a" = 1
        "us-east-1b" = 2
    }
}

variable "private_subnet_numbers" {
    type = map(number)
    description = "Map of AZ to a number that should be used for private subnets"

    default = {
        "us-east-1a" = 3
        "us-east-1b" = 4
    }
}
