#fetching the AMI ID for us-east-1 region

data "aws_ami" "web_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

#Create Web Server EC2 Instance

resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.web_ami.id
  instance_type          = var.instance_type
  availability_zone      = var.az
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.web-subnet-1.id
  user_data              = file("apache.sh")

  tags = {
    Name = "Web Server"
  }

}

