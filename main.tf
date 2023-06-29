resource "aws_instance" "ec2_instance" {
  ami             = var.ami_id
  subnet_id       = var.subnet_id
  instance_type   = var.instance_type
  key_name        = var.ami_key_pair_name
  security_groups = var.security_groups_id
  user_data       = data.template_file.user_data.rendered
  tags = {
    Name = "Jupyter-backstage-demo"
    Env  = "Test"
  }
} 