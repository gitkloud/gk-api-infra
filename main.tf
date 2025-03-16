resource "aws_s3_bucket" "my_bucket" {
    bucket = "${var.project}-${var.env}-bucket"
    acl = "private"
    versioning {
        enabled = true
    }

    tags = var.tags
}

resource "aws_s3_bucket" "my_bucket2" {
    bucket = "${var.project}-${var.env}-bucket2"
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
