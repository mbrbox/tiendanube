resource "aws_lb" "test-alb" {
  name               = "${var.project_name}-test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
    subnets         = "${data.aws_subnet_ids.all.ids}"
  enable_deletion_protection = false

  
  tags = {
    Environment = "Test"
  }
}

resource "aws_lb_target_group" "test-alb" {
  name         = "test-alb0-web"
  protocol     = "HTTP"
  port         = 80
  vpc_id = "${data.aws_vpc.default.id}"
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = 80  
  }
}

resource "aws_lb_listener" "test-alb" {
  load_balancer_arn = "${aws_lb.test-alb.arn}"
  port = "80"
  default_action {
    target_group_arn = "${aws_lb_target_group.test-alb.arn}"
    type = "forward"
  }
}

resource "aws_lb_target_group_attachment" "tg1" {
  target_group_arn = "${aws_lb_target_group.test-alb.arn}"
  target_id        = "${aws_instance.web.id}"
  port             = 80
}

resource "aws_alb_target_group_attachment" "tg2" {
  target_group_arn = "${aws_lb_target_group.test-alb.arn}"
  target_id        = "${aws_instance.apache.id}"
  port             = 80
}