resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.ms.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "${var.vpc_name}-rt"
    }
  
}

resource "aws_route_table_association" "publicsubnetassociation" {
    count = 3
    subnet_id = element(aws_subnet.publicsubnets.*.id, count.index)
    route_table_id = aws_route_table.rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.ms.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ngw.id
    }
    tags = {
      Name = "${var.vpc_name}-private-rt"
    }
  
}

resource "aws_route_table_association" "privatesubnetassociation" {
    count = 3
    subnet_id = element(aws_subnet.privatesubnets.*.id, count.index)
    route_table_id = aws_route_table.private_rt.id
  
}