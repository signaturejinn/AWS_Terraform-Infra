# launch configuration
resource "aws_launch_configuration" "web" {
  name_prefix     = "lc-web-"
  image_id        = aws_ami_from_instance.ami.id   # 생성한 ami이미지를 image_id로 설정
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web.id]
  key_name        = aws_key_pair.mykey.key_name

/*  user_data = templatefile("userdata.tftpl", {
    port_number = var.server_port
  })
*/

  lifecycle {
    create_before_destroy = true
  }
}

# autoscaling group
resource "aws_autoscaling_group" "web" {
  name_prefix          = "asg-web-"
  launch_configuration = aws_launch_configuration.web.name
  vpc_zone_identifier  = [aws_subnet.pri_a.id, aws_subnet.pri_c.id]

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size         = 2
  desired_capacity = 4
  max_size         = 10

  tag {
    key                 = "Name"
    value               = "tf-asg-web"
    propagate_at_launch = true
  }
    # Rolling update 기능
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}

# autoscaling policy
resource "aws_autoscaling_policy" "web" {
  name                      = "asg-scaling-policy"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.web.id
  estimated_instance_warmup = 200
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "60"
  }
}