output "vpc_id" {
  value       = aws_vpc.vpc.id
}

# output "vpc_cidr" {
#   value       = aws_vpc.cidr_block.id
# }

output "vpc_public_subnets" {

// Result is a map of subnet id to cidr block, e.g.
// { "subnet_1234 => "10.0.1.0/3", ...} 

    value = {
        for subnet in aws_subnet.public :
        subnet.id => subnet.cidr_block
    }
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