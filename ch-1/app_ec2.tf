#fetching the AMI ID for us-east-1 region

data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

#Create Application Server EC2 Instance

resource "aws_instance" "appserver" {
  ami                    = data.aws_ami.app_ami.id
  instance_type          = var.instance_type
  availability_zone      = var.az
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  subnet_id              = aws_subnet.application-subnet-1.id

  tags = {
    Name = "App Server"
  }

}
