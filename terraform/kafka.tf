# resource "aws_vpc" "msk_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "msk-vpc"
#   }
# }

# resource "aws_subnet" "msk_subnet_a" {
#   vpc_id            = aws_vpc.msk_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-west-2a"
# }

# resource "aws_subnet" "msk_subnet_b" {
#   vpc_id            = aws_vpc.msk_vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "us-west-2b"
# }


# resource "aws_security_group" "msk_security_group" {
#   vpc_id = aws_vpc.msk_vpc.id

#   ingress {
#     from_port   = 9092
#     to_port     = 9092
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/16"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "msk-security-group"
#   }
# }

# resource "aws_msk_cluster" "msk_cluster" {
#   cluster_name           = "my-msk-cluster"
#   kafka_version          = "2.6.0"
#   # kafka_version          = "3.6.0"
#   number_of_broker_nodes = 2
#   broker_node_group_info {
#     instance_type = "kafka.t3.small"
#     client_subnets = [
#       aws_subnet.msk_subnet_a.id,
#       aws_subnet.msk_subnet_b.id
#     ]
#     security_groups = [aws_security_group.msk_security_group.id]
#   }

#   # encryption_info {
#   #   encryption_in_transit {
#   #     client_broker = "TLS"
#   #     in_cluster    = true
#   #   }
#   # }

#   logging_info {
#     broker_logs {
#       cloudwatch_logs {
#         enabled         = true
#         log_group       = aws_cloudwatch_log_group.msk_log_group.name
#       }
#     }
#   }

#   tags = {
#     Name = "ThoughtsMSKCluster"
#   }
# }

# resource "aws_cloudwatch_log_group" "msk_log_group" {
#   name = "/aws/msk/thoughts-msk-cluster"
# }