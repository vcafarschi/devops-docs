################################################################################
# Create BASTION host
################################################################################
resource "aws_instance" "bastion" {
  ami                    = "ami-0443305dabd4be2bc"
  instance_type          = "t2.micro"
  key_name               = "aws-sandbox-vcafarschi"
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  subnet_id              = aws_subnet.bastion-subnet.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-bastion" }
  )
}

################################################################################
# Create SG-BASTION
################################################################################
resource "aws_security_group" "bastion-sg" {
  name   = "bastion-sg"
  vpc_id = aws_vpc.this.id
}

################################################################################
# INGRESS-SG-RULE for BASTION SG
################################################################################
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.my_ip]
  security_group_id = aws_security_group.bastion-sg.id
}

################################################################################
# EGRESS-SG-RULE for BASTION SG
################################################################################
resource "aws_security_group_rule" "ssh-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion-sg.id
}
