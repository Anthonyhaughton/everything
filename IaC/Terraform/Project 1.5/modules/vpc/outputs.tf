output "vpc_id" {
  value       = aws_vpc.vpc.id
}

# output "vpc_public_subnets" {

# // Result is a map of subnet id to cidr block, e.g.
# // { "subnet_1234 => "10.0.1.0/3", ...} 

#     value = {
#         for subnet in aws_subnet.public :
#         subnet.id => subnet.cidr_block
#     }
# }

# 12/29/23: I was able to reuse the output bock from my LAMP project to fix an error I was having here
# If you look at the commented block above it was causing my vpc_identifier to fail in my asg block 
# but with this new output it was able to pass both public subnets. 

output "vpc_public_subnets" {
  description = "List of subnet IDs created in the VPC"
  value       = [for subnet in aws_subnet.public : subnet.id] 
}

output "vpc_private_subnets" {


    value = {
        for subnet in aws_subnet.private :
        subnet.id => subnet.cidr_block
    }
}

output "security_group_public" {
  value = aws_security_group.public.id
}