variable "env" {
    description = "Environment"
    type = string
    default = "dev"
}

variable "project" {
    description = "Project Name"
    type = string
    default = "gk-project"
}

variable "ami" {
    description = "AMI ID"
    type = string
    default = "ami-08b5b3a93ed654d19"
  
}

variable "instance_type" {
    description = "Instance Type"
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    description = "Key Pair Name"
    type = string
    default = "bpantala-keypair"

}


variable "vpc_id" {
    description = "VPC ID"
    type = string
    default = "vpc-017981d0907d9a5b3"
}

variable "cidr_blocks" {
  description = "cidr_blocks"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "tags" {
    description = "tags"
    type = map(string)
    default = {
      "Environment" = "Dev"
      "Project" = "gK-Project"
      "Terraform" = true
    }
}