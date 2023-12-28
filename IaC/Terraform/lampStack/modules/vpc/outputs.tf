output environment {
  value       = ""
  description = "dev/prod/test"
}


output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.lamp-vpc.id
}

# output "subnet_ids" {
#   description = "List of subnet IDs created in the VPC"
#   value       = tolist(values(aws_subnet.public_subnets)[*].id)
# }

# output "subnet_ids" {
#   description = "List of subnet IDs created in the VPC"
#   value       = values(aws_subnet.public_subnets)[*].id
# }

# output "subnet_ids" {
#   description = "List of subnet IDs created in the VPC"
#   value       = flatten([for subnet in aws_subnet.public_subnets : subnet.id])
# }

output "subnet_ids" {
  description = "List of subnet IDs created in the VPC"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.lamp_rt.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.lamp_igw.id
}
