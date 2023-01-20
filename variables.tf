# image
variable "image_id" {
  description = "The name of the instance_ami"
  type        = string
  default     = ""
}

# instance
variable "instance_type" {
  description = "The name of the instance_type"
  type        = string
  default     = "t3.micro"
}

# server port
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

# instance security group
variable "instance_security_group_name" {
  description = "The name of the secruity group for the EC2 Instances"
  type        = string
  default     = "allow_http_instance"
}

# DB 변수
variable "db_security_group_name" {
  type    = string
  default = "allow_mysql_db"
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "tf-alb"
}