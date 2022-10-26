resource "aws_security_group" "allow_traffic_alb" {
  name        = "allow_traffic_alb"
  description = "Allow HTTP & SSH inbound traffic through AWS ALB"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_alb_traffic"
  }
}

resource "aws_security_group" "allow_traffic_ec2" {
  name        = "allow_traffic_ec2"
  description = "Allow HTTP & SSH inbound traffic through EC2"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    description      = "TLS from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.allow_traffic_alb.id]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.allow_traffic_alb.id]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ec2_traffic"
  }
}