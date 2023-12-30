output environment {
  value       = "dev"
  description = "dev/prod/test"
}

output "project" {
  description = "Project name for the tags"
  value = "project-alb"
}

output "managedby" {
  description = "desc for tags"
  value = "terraform"
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.dev-vpc.id
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
  value       = aws_route_table.dev_rt.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.dev_igw.id
}
