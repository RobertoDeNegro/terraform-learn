provider "aws" {
  region = "us-east-1"
}

variable "cidr_blocks" {
  description = "cidr block fand name for vpc and subnets"
  type = list(object({
    cidr_block = string
    name = string
  }))
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
      name: var.cidr_blocks[0].name 
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "us-east-1a"
    tags = {
      name: var.cidr_blocks[1].name
    }
}
/*
data "aws_vpc" "exsisting_data" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.exsisting_data.id
    cidr_block = "172.31.160.0/20"
    availability_zone = "us-east-1a"
}
*/
output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}