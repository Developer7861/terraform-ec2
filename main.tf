resource "aws_security_group" "jenkins" {
  name = "jenkins-sg"
  description = "open 22, 80, 443, 8080, 9000"

  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000] : {
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "TLS from VPC"
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_instance" "jenkins" {
  ami = "ami-033a1ebf088e56e81"
  instance_type = "t2.micro"
  key_name = "new-account"
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  user_data = templatefile("./install-jenkins.sh", {})

  tags = {
    Name = "jenkins"
  }
#   root_block_device {
#     volume_size = 30
#   }
}