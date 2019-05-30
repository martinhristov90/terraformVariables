variable "access_key"  {}
variable "secret_key" {}


provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "web" {
    ami = "ami-0444fa3496fb4fab2"
    instance_type = "t2.micro"
    

    subnet_id = "subnet-2f591701"
    vpc_security_group_ids = [
        "sg-3ddbcb64"
    ]

    tags {
        "name" = "MYMACHINE"
        "ping" = "pong"
    }
  
}

