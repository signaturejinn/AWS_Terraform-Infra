#AMI 
resource "aws_ami_from_instance" "ami" {
  name               = "terraform-ami"
  source_instance_id = aws_instance.web_pub.id

  tags = {
    Name = "tf-ami"
  }
}