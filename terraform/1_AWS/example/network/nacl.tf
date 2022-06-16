################################################################################
# NACL for BASTION subnet
################################################################################
resource "aws_network_acl" "bastion-subnet-nacl" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = aws_subnet.bastion-subnet

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-nacl-pub-subnet" }
  )
}
################################################################################
# NACL for PUBLIC subnet
################################################################################
resource "aws_network_acl" "pub-subnet-nacl" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = aws_subnet.pub-subnet.*.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-nacl-pub-subnet" }
  )
}

################################################################################
# NACL for PRIVATE subnet
################################################################################
resource "aws_network_acl" "pvt-subnet-nacl" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = aws_subnet.pvt-subnet.*.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-nacl-pvt-subnet" }
  )
}

################################################################################
# INGRESS-NACL-RULE for BASTION subnet
# allows inbound traffic from my ip to BASTION subnet
################################################################################
resource "aws_network_acl_rule" "ingres-ssh-pub" {
  network_acl_id = aws_network_acl.bastion-subnet-nacl.id
  rule_number    = 10
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.my_ip
  from_port      = 22
  to_port        = 22
}

################################################################################
# EGRESS-NACL-RULE for BASTION Subnet
# allows outbound traffic from BASTION to my ip
################################################################################
resource "aws_network_acl_rule" "egress-back-ssh" {
  network_acl_id = aws_network_acl.bastion-subnet-nacl.id
  rule_number    = 10
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.my_ip
  from_port      = 1024
  to_port        = 65535
}

################################################################################
# INGRESS-NACL-RULE for PUBLIC Subnet
# allows inbound traffic from private subnet
################################################################################
resource "aws_network_acl_rule" "ingress-all" {
  network_acl_id = aws_network_acl.pub-subnet-nacl.id
  rule_number    = 10
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = ["0.0.0.0/0"]
  from_port      = 80
  to_port        = 80
}

################################################################################
# INGRESS-NACL-RULE for PRIVATE Subnet
#
################################################################################
resource "aws_network_acl_rule" "pvt-ingres-ssh" {
  network_acl_id = aws_network_acl.pvt-subnet-nacl.id
  rule_number    = 20
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.this.cidr_block
  from_port      = 1024
  to_port        = 65535
}

################################################################################
# EGRESS-NACL-RULE for PUBLIC Subnet

################################################################################
resource "aws_network_acl_rule" "nacl2-egress-ssh" {
  network_acl_id = aws_network_acl.pub-subnet-nacl.id
  rule_number    = 10
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.this.cidr_block
  from_port      = 1024
  to_port        = 65535
}

################################################################################
# EGRESS-NACL-RULE for PUBLIC Subnet

################################################################################
resource "aws_network_acl_rule" "nacl2-egress-ssh" {
  network_acl_id = aws_network_acl.pub-subnet-nacl.id
  rule_number    = 10
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = ["0.0.0.0/0"]
  from_port      = 1024
  to_port        = 65535
}


################################################################################
# EGRESS-NACL-RULE for PRIVATE Subnet
################################################################################
resource "aws_network_acl_rule" "pvt-egress-back-ssh" {
  network_acl_id = aws_network_acl.pvt-subnet-nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.this.cidr_block
  from_port      = 1024
  to_port        = 65535
}

################################################################################
# INGRESS-NACL-RULE for PRIVATE Subnet
# allows inbound traffic from LB
################################################################################
resource "aws_network_acl_rule" "pvt-ingres-lb" {
  network_acl_id = aws_network_acl.pvt-subnet-nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.this.cidr_block
  from_port      = 5000
  to_port        = 5000
}

