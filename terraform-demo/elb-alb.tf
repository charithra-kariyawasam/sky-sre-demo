resource "aws_lb" "elb_alb" {
  name               = "application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_traffic_alb.id]
  subnets            = [aws_subnet.public_1.id,aws_subnet.public_2.id,aws_subnet.public_3.id]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.elb_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ec2servers.arn
    }
}

resource "aws_lb_target_group" "ec2servers" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  health_check {
    interval                = 10
    path                    = "/"
    protocol                = "HTTP"
    timeout                 = 5
    healthy_threshold       = 5
    unhealthy_threshold     = 2 

  } 
  target_type="instance"
  vpc_id                  = aws_vpc.vpc_demo.id
}

resource "aws_lb_target_group_attachment" "ec2-1-attachment" {
  target_group_arn = aws_lb_target_group.ec2servers.arn
  target_id        = aws_instance.ec2-1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "ec2-2-attachment" {
  target_group_arn = aws_lb_target_group.ec2servers.arn
  target_id        = aws_instance.ec2-2.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "ec2-3-attachment" {
  target_group_arn = aws_lb_target_group.ec2servers.arn
  target_id        = aws_instance.ec2-3.id
  port             = 80
}

output "elb_example" {
  description = "The DNS name of the ELB"
  value       = aws_lb.elb_alb.dns_name
}