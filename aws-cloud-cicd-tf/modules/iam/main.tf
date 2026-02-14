variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}

resource "aws_iam_role" "ec2_role" {
  name = "role-brava-ec2-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "policy-brava-ec2-${var.environment}"
  role = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Sid    = "SSMSession"
        Effect = "Allow"
        Action = [
          "ssm:UpdateInstanceInformation"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "profile-brava-ec2-${var.environment}"
  role = aws_iam_role.ec2_role.name
}

output "role_arn" {
  value = aws_iam_role.ec2_role.arn
}

output "instance_profile_id" {
  value = aws_iam_instance_profile.ec2_profile.id
}
