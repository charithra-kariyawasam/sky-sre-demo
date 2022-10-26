#### Setup 3 EC2 Instances in 3 AZ in the considerning region####
resource "aws_instance" "ec2-1" {
    ami                     = "ami-08c40ec9ead489470"
    instance_type           = "t2.micro"
    subnet_id               = aws_subnet.public_1.id
    vpc_security_group_ids  = [aws_security_group.allow_traffic_ec2.id]
    user_data               = file("bootstrap.sh")
    key_name = "demoEC2Key"
    tags = {
        Name = "EC2-AZ-1a"
    }
}

resource "aws_instance" "ec2-2" {
    ami                     = "ami-08c40ec9ead489470"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.allow_traffic_ec2.id]
    user_data               = file("bootstrap.sh")    
    subnet_id               = aws_subnet.public_2.id
    key_name = "demoEC2Key"
    tags = {
        Name = "EC2-AZ-1b"
    }
}

resource "aws_instance" "ec2-3" {
    ami                     = "ami-08c40ec9ead489470"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.allow_traffic_ec2.id]
    user_data               = file ("bootstrap.sh")      
    subnet_id               = aws_subnet.public_3.id
    key_name = "demoEC2Key"
    tags = {
        Name = "EC2-AZ-1c"
    }
}

