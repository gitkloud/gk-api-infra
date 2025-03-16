resource "aws_s3_bucket" "my_bucket" {
    bucket = "${var.project}-${var.env}-bucket"
    acl = "private"
    versioning {
        enabled = true
    }

    tags = var.tags
}

resource "aws_instance" "my_instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    iam_instance_profile = aws_iam_role.instance_role.name
    tags = var.tags
}

resource "aws_security_group" "my_sg" {
    name = "${var.project}-${var.env}-instance-sg"
    description = "Allow inbound traffic on port 22"
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.cidr_blocks
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.cidr_blocks
    }
    tags = var.tags
}

resource "aws_iam_role" "instance_role" {
  name = "${var.project}-${var.env}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = var.tags
  
}
resource "aws_iam_policy" "instance_s3_policy" {
  name        = "${var.project}-${var.env}-policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListMyBucket"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.my_bucket.arn}/*"
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "s3policy_attachment_role"{


  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.instance_s3_policy.arn
}