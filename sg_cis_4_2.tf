locals {
  goat_cis_4_2_group_name = "sg_goat_cis_4_2"
}

resource "aws_security_group" "goat_cis_4_2" {
  count       = var.enabled ? 1 : 0    
  name        = local.goat_cis_4_2_group_name
  description = "Goat-CIS-4.2-Allow RDP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name        = local.goat_cis_4_2_group_name
  }
}