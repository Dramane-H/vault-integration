
data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = var.name
  region  = "${var.region}"
}

resource "aws_instance" "ec2-vault-instance" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "ec2-vault-instance"
  }
}


data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "employee-webapp" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  user_data = <<-EOF
    wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/DEV-AWS-MO-GCNv2/FlaskApp.zip
    unzip FlaskApp.zip
    cd FlaskApp/
    yum -y install python3 mysql
    pip3 install -r requirements.txt
    amazon-linux-extras install epel
    yum -y install stress
    export PHOTOS_BUCKET=${SUB_PHOTOS_BUCKET}
    export AWS_DEFAULT_REGION=<INSERT REGION HERE>
    export DYNAMO_MODE=on
    FLASK_APP=application.py /usr/local/bin/flask run --host=0.0.0.0 --port=80
  EOF
}


