# Worker Nodes
resource "aws_instance" "worker" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.k8s_subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  user_data              = base64encode(templatefile("Worker.sh", { master_ip = aws_instance.master.private_ip }))

  tags = {
    Name = "k8s-worker-${count.index}"
  }
}
