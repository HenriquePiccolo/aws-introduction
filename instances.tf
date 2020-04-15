resource "aws_instance" "instances" {
  count = 3

  #ami = "ami-0323c3dd2da7fb37d"
  ami = "ami-0fc61db8544a617ed"
  instance_type = "t2.micro"
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)

  key_name = aws_key_pair.key_pair.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.database.id]

  tags = {
      Name = "zup_instances"
  }
}

resource "aws_key_pair" "key_pair"{
  public_key = file("key/zup_key.pub")
}

output "public_ips"{
    value = join(", ", aws_instance.instances.*.public_ip)
}