# Worker Nodes
resource "aws_instance" "worker" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  key_name               = "key-pair"
  subnet_id              = aws_subnet.k8s_subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  
  tags = {
    Name = "k8s-worker-${count.index}"
  }
}
