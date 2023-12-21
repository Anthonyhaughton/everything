resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "my-dev-vpc"
        Project = "1.5"
        #Environment = var.env
        ManagaedBy = "terrafrom"
    }
}

resource "aws_subnet" "public" {
    for_each = var.public_subnet_numbers // for_each information below
    vpc_id = aws_vpc.vpc.id

    // The "cidrsubnet" func takes in (prefix, newbits, netnum). So first we passed in the default vpc_cidr that will default to /16
    // Next the newbits number will add to the /16 so in this case the /16 will become a /28 (+12). So newbits just takes in your huge IP address
    // pool and is able to shink it down. Lastly the netnum will bring you to the next subnet range or octet, I think?
    
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 12, each.value ) 

    tags = {
        Name = "my-dev-public-subnet"
        Project = "1.5"
        Role = "public"
        #Environment = var.env
        ManagaedBy = "terrafrom"
        Subnet = "${each.key}-${each.value}" // each. defined below in comments
    }
}



// the "for_each" func allows you loop over something that is iterable in this case we used a map. It says for each item in that map create an instance
// of that resource.

// We also used the word "each" where we get a "key" and a "value" because there is a map. ie key = us-east-1a, value = 1

resource "aws_subnet" "private" {
    for_each = var.private_subnet_numbers 
    vpc_id = aws_vpc.vpc.id

    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 12, each.value )

    tags = {
        Name = "my-dev-private-subnet" // my-${var.env}-private-subnet"
        Project = "1.5"
        Role = "private"
        #Environment = var.env
        ManagaedBy = "terrafrom"
        Subnet = "${each.key}-${each.value}"
    }
}