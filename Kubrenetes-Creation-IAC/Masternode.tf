data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
# Master Node
resource "aws_instance" "master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.k8s_subnets[0].id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  user_data              = base64encode(file("Master.sh"))

  tags = {
    Name = "k8s-master"
  }
}
