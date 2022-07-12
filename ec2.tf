
data "aws_ami" "WINDOWS" {
    most_recent = true
    owners = ["453307492034"]
    # name = "ansible-controller"
    filter {
        name = "name"
        values = ["ansible-controller"]
    }

    # filter {
    #   image_id = ["ami-a51376b2"]
    # }

}

data "aws_ami" "RHEL" {
    most_recent = true
    owners = ["453307492034"]
    # name = "rhel-image"
    filter {
        name = "name"
        values = ["rhel-image"]
    }

    # filter {
    #   image_id = ["ami-0515a52f71573c20a"]
    # }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-example"
  }
}







resource "aws_instance" "webec2" {

  ami                    = var.os_type ==  "WINDOWS"  ?  data.aws_ami.WINDOWS.id  :  data.aws_ami.RHEL.id
  instance_type          = var.instance_type
  # subnet_id              = aws_subnet.web_public_subnets[count.index].id
  subnet_id              =  aws_subnet.my_subnet.id
#   vpc_id = aws_vpc.my_vpc.id

}



# variable "ami" {
#     type = string
# }

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "os_type" {
    type = string 
    default = "WINDOWS"
}