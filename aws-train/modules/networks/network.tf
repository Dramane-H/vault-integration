data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = "../vaults/terraform.tfstate"
  }
}


data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.role
  region  = var.region
}


# Adding route table

resource "aws_route_table" "example" {  
  vpc_id = aws_default_vpc.default.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "example"
  }
}

#  adding internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "main"
  }
}

#  adding vpc. will work on the default one
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# adding secrurity group

resource "aws_security_group" "sg_employedirect" {
  name        = "allow_traffic"
  description = "Allow inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "allow https traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "HTTPS"
    cidr_blocks      = [aws_default_vpc.default.cidr_block]
    ipv6_cidr_blocks = [aws_default_vpc.default.cidr_block]
  }

  ingress {
    description      = "allow http traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "HTTP"
    cidr_blocks      = [aws_default_vpc.default.cidr_block]
    ipv6_cidr_blocks = [aws_default_vpc.default.cidr_block]
  }

  ingress {
    description      = "allow ssh connection"
    from_port        = 22
    to_port          = 22
    protocol         = "SSH"
    cidr_blocks      = [aws_default_vpc.default.cidr_block]
    ipv6_cidr_blocks = [aws_default_vpc.default.cidr_block]
  }

    ingress {
    description      = "allow TCP connection"
    from_port        = 8080
    to_port          = 8080
    protocol         = "TCP"
    cidr_blocks      = [aws_default_vpc.default.cidr_block]
    ipv6_cidr_blocks = [aws_default_vpc.default.cidr_block]
    }

}