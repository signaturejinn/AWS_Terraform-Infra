# aws_key_pair
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}

# image
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["137112412989"]
  name_regex  = "^amzn2-" # regex : regular expression
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# security group
resource "aws_security_group" "web" {
  name        = var.instance_security_group_name
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# instance (public subnet)
resource "aws_instance" "web_pub" {
  ami                         = var.image_id == "" ? data.aws_ami.amazon_linux.id : var.image_id # Amazon Linux 2 (ap-northeast-2)
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data_replace_on_change = true
  key_name                    = aws_key_pair.mykey.id
  subnet_id                   = aws_subnet.pub_c.id

  user_data = templatefile("userdata.tftpl", {
    address = "${aws_db_instance.lab-db.address}",
    username = "${aws_db_instance.lab-db.username}",
    db_name  = "${aws_db_instance.lab-db.db_name}",
    password = "${aws_db_instance.lab-db.password}"
  })  # RDS 자동연결하는 userdata추가

  tags = {
    Name = "tf-web-pub"
  }
}

# instance (private subnet)
resource "aws_instance" "web_pri" {
  ami                         = var.image_id == "" ? data.aws_ami.amazon_linux.id : var.image_id # Amazon Linux 2 (ap-northeast-2)
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data_replace_on_change = true
  key_name               = aws_key_pair.mykey.id
  subnet_id                   = aws_subnet.pri_c.id

  tags = {
    Name = "tf-web-pri"
  }
}