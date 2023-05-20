resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port}  &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}
#The user_data_replace_on_change parameter is set to true so that when you change the user_data parameter and run apply, Terraform will terminate the original instance and launch a totally new one    