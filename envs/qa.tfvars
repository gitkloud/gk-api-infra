env = "qa"
project = "gk-project"
ami = "ami-08b5b3a93ed654d19"
instance_type = "t2.micro"
key_name = "bpantala-keypair"
vpc_id = "vpc-017981d0907d9a5b3"
cidr_blocks = ["0.0.0.0/0"]
tags = {
  "Environment" = "QA"
  "Project" = "gK-Project"
  "Terraform" = true
}
