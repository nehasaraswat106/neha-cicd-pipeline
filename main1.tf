# main.tf

provider "aws" {
  region = "us-east-1" # Replace with your preferred region
}

# Launch Template
resource "aws_launch_template" "example" {
  name_prefix          = "example-"
  image_id             = "ami-0866a3c8686eaeeba" # Replace with your AMI ID
  instance_type        = "t2.micro"
  key_name             = "terra-key" # Replace with your SSH key

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["sg-0e3769708b4947e03"] # Replace with your security group
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = ["subnet-0f5adb0574bd02c7a"] # Replace with your subnet ID

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

# Scaling Policies and CloudWatch Alarms remain unchanged.
