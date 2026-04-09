resource "aws_eip" "ram" {
    
    tags = {
      Name = "${var.vpc_name}-eip"
    }
  
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.ram.id
    subnet_id = element(aws_subnet.publicsubnets.*.id, 0)
    tags = {
      Name = "${var.vpc_name}-ngw"
    }

  
}