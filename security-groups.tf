resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Creating Sg for my private app"
  vpc_id      = data.aws_vpc.canary_vpc.id

  #INBOUND CONNECTIONS
  ingress {
    description     = "Allow SSH into the instance from the public instance private IP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  #OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "loadbalancer_sg" {
  name        = "lb_sg"
  description = "Allow access to this LB"
  vpc_id      = data.aws_vpc.canary_vpc.id


  #INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the instance from the public instance private IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Access to the webserver from internet
  }

  #OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}