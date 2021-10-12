#NAT Gateway and Elastic IP

resource "aws_eip" "nat-eip" {
  vpc = true

  tags = {
    Name = "NAT-EIP"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.web-subnet-1.id

  tags = {
    Name = "Demo NAT"
  }
}


#Private Subnet Route Tables and Associations
resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "PvtRT"
  }
}

resource "aws_route_table_association" "app-rt_assoc" {
  subnet_id      = aws_subnet.application-subnet-1.id
  route_table_id = aws_route_table.pvt-rt.id
}

resource "aws_route_table_association" "db-rt_assoc" {
  subnet_id      = aws_subnet.database-subnet-1.id
  route_table_id = aws_route_table.pvt-rt.id
}