output "security_group_id" {
    value = "${aws_security_group.allow_ssh_anywhere.id}"
}

output "security_group_name" {
    value = "${aws_security_group.allow_http_anywhere.name}"
}

output "security_group_desc" {
    value = "${aws_security_group.allow_http_anywhere.description}"
}

output "this_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = "${aws_lb.test-alb.dns_name}"
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = "${aws_instance.web.public_ip}"
}