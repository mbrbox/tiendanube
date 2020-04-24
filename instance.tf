resource "aws_instance" "web" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.keypair.key_name}"

  vpc_security_group_ids = [ 
    "${aws_security_group.allow_ssh_anywhere.id}" , 
    "${aws_security_group.allow_http_anywhere.id}"
  ]

  tags = {
    Name = "${var.project_name}-Prueba-Nginx"
  }

  user_data = "${file("user-data-nginx.txt")}"
}
resource "aws_instance" "apache" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.keypair.key_name}"
   
  vpc_security_group_ids = [ 
    "${aws_security_group.allow_ssh_anywhere.id}" , 
    "${aws_security_group.allow_http_anywhere.id}"
  ]

  tags = {
    Name = "${var.project_name}-Prueba-apache"
  }
 user_data = "${file("user-data-apache2.txt")}"
}