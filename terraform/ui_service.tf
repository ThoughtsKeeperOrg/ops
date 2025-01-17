resource "aws_ecr_repository" "thoughts_keeper_ui_ecr_repo" {
  name = "thoughts_keeper_ui-repo"
}

# resource "aws_ecs_task_definition" "ui_task" {
#   family                   = "ui-task" # Name your task
#   container_definitions    = <<DEFINITION
#   [
#     {
#       "name": "ui-task",
#       "image": "${aws_ecr_repository.thoughts_keeper_ui_ecr_repo.repository_url}",
#       "essential": true,
#       "portMappings": [
#         {
#           "containerPort": 3000,
#           "hostPort": 3000
#         }
#       ],
#       "memory": 512,
#       "cpu": 256,
#       "environment": [{
#         "name": "REACT_APP_BE_API_URL",
#         "value": "http://${aws_alb.ltm_application_load_balancer.dns_name}"
#       }]
#     }
#   ]
#   DEFINITION
#   requires_compatibilities = ["FARGATE"] # use Fargate as the launch type
#   network_mode             = "awsvpc"    # add the AWS VPN network mode as this is required for Fargate
#   memory                   = 512         # Specify the memory the container requires
#   cpu                      = 256         # Specify the CPU the container requires
#   execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRoleThoughtsKeeper.arn}"
# }

# # Create a security group for the load balancer:
# resource "aws_security_group" "ui_load_balancer_security_group" {
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allow traffic in from all sources
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


# resource "aws_alb" "ui_application_load_balancer" {
#   name               = "ui-balancer" #load balancer name
#   load_balancer_type = "application"
#   subnets = [ # Referencing the default subnets
#     "${aws_default_subnet.default_subnet_a.id}",
#     "${aws_default_subnet.default_subnet_b.id}"
#   ]
#   # security group
#   security_groups = ["${aws_security_group.ui_load_balancer_security_group.id}"]
# }

# resource "aws_lb_target_group" "ui_target_group" {
#   name        = "target-group"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "ip"
#   vpc_id      = "${aws_default_vpc.default_vpc.id}" # default VPC
# }

# resource "aws_lb_listener" "ui_listener" {
#   load_balancer_arn = "${aws_alb.ui_application_load_balancer.arn}" #  load balancer
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = "${aws_lb_target_group.ui_target_group.arn}" # target group
#   }
# }


# resource "aws_ecs_service" "ui_service" {
#   name            = "ui-service"     # Name the service
#   cluster         = "${aws_ecs_cluster.thoughts_cluster.id}"   # Reference the created Cluster
#   task_definition = "${aws_ecs_task_definition.ui_task.arn}" # Reference the task that the service will spin up
#   launch_type     = "FARGATE"
#   desired_count   = 1 # Set up the number of containers to 3

#   load_balancer {
#     target_group_arn = "${aws_lb_target_group.ui_target_group.arn}" # Reference the target group
#     container_name   = "${aws_ecs_task_definition.ui_task.family}"
#     container_port   = 3000 # Specify the container port
#   }

#   network_configuration {
#     subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
#     assign_public_ip = true     # Provide the containers with public IPs
#     security_groups  = ["${aws_security_group.ui_service_security_group.id}"] # Set up the security group
#   }
# }

# resource "aws_security_group" "ui_service_security_group" {
#   ingress {
#     from_port = 0
#     to_port   = 0
#     protocol  = "-1"
#     # Only allowing traffic in from the load balancer security group
#     security_groups = ["${aws_security_group.ui_load_balancer_security_group.id}"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# output "ui_web_url" {
#   value = aws_alb.ui_application_load_balancer.dns_name
# }