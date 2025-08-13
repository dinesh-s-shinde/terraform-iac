terraform {
    required_version = "1.15.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.51.0"
        }
    }
}

resource "aws_instance" "app-vm" {
    ami = ""
    instance_type = "t2.micro"
}
