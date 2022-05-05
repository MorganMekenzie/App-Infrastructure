resource "aws_launch_template" "blue_template" {
  name_prefix            = "blue_template"
  image_id               = data.aws_ami.wordpress_ami.id
  instance_type          = var.ec2_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]
   iam_instance_profile {
    name = "wordpress_server_profile"
  }
}

resource "aws_autoscaling_group" "blue" {
  name                = "blue_group"
  desired_capacity    = 1
  max_size            = 3
  min_size            = 0
  health_check_type   = "ELB"
  force_delete        = true
  vpc_zone_identifier = [data.aws_subnet.private_a.id]

  launch_template {
    id      = aws_launch_template.blue_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Blue-Server"
    propagate_at_launch = true
  }

  timeouts {
    delete = "5m"
  }
}