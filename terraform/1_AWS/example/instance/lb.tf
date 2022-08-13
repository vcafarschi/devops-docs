################################################################################
# Create Classic Load Balancer
################################################################################
resource "aws_elb" "classic-lb" {
  name               = "vcafarschi-classic-lb"
  security_groups    = [aws_security_group.classic-lb.id]
//  subnets            = [data.aws_subnet.pub-subnet.*.id] with square bracket the wildcard * doesnt work
  subnets            = [data.aws_subnet.lb-subnet-0.id,data.aws_subnet.lb-subnet-1.id]

  listener {
    lb_port           = var.lb_port
    lb_protocol       = "http"
    instance_port     = var.app_port
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.app_port}/"
    interval            = 30
  }

  instances                   = [aws_instance.py-app.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-classic-lb" }
  )
}

################################################################################
# SG for Classic Load Balancer
################################################################################
resource "aws_security_group" "classic-lb" {
  name   = "classic-lb"
  vpc_id = data.aws_vpc.vcafarschi-vpc.id
}

################################################################################
# INGRESS-SG-RULE for Classic Load Balancer
################################################################################
resource "aws_security_group_rule" "classic-lb-rule" {
  type                     = "ingress"
  from_port                = var.lb_port
  to_port                  = var.lb_port
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.classic-lb.id
}

################################################################################
# EGRESS-SG-RULE for Classic Load Balancer
################################################################################
resource "aws_security_group_rule" "lb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.classic-lb.id
}
