variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "tags" {
  type = map(string)
}

resource "aws_security_group" "this" {
  name        = "sg-brava-\"
  description = "Brava Cloud Demos security group"
  vpc_id      = var.vpc_id
  
  tags = merge(var.tags, { Name = "sg-\" })
}

resource "aws_security_group_rule" "ingress" {
  count             = length(var.ingress_rules)
  type              = "ingress"
  security_group_id = aws_security_group.this.id
  
  from_port       = var.ingress_rules[count.index].from_port
  to_port         = var.ingress_rules[count.index].to_port
  protocol        = var.ingress_rules[count.index].protocol
  cidr_blocks     = var.ingress_rules[count.index].cidr_blocks
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  security_group_id = aws_security_group.this.id
  
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

output "security_group_id" {
  value = aws_security_group.this.id
}
