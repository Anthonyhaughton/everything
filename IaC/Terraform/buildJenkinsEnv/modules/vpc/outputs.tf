output environment {
  value       = "dev"
  description = "dev/prod/test"
}

output "managedby" {
  description = "desc for tags"
  value = "terraform"
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.dev-vpc.id
}

output "subnet_id" {
  description = "List of subnet IDs created in the VPC"
  value       =  aws_subnet.public_subnet.id
}

output "route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.dev_rt.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.dev_igw.id
}
