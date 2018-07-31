output "cluster_name" {
  value = "craft-k8s.linux-zone.com"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-craft-k8s-linux-zone-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-craft-k8s-linux-zone-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-craft-k8s-linux-zone-com.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-1a-craft-k8s-linux-zone-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-craft-k8s-linux-zone-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-craft-k8s-linux-zone-com.name}"
}

output "region" {
  value = "us-east-1"
}

output "vpc_id" {
  value = "${aws_vpc.craft-k8s-linux-zone-com.id}"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-craft-k8s-linux-zone-com" {
  name                 = "master-us-east-1a.masters.craft-k8s.linux-zone.com"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-craft-k8s-linux-zone-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-craft-k8s-linux-zone-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "craft-k8s.linux-zone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1a.masters.craft-k8s.linux-zone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-craft-k8s-linux-zone-com" {
  name                 = "nodes.craft-k8s.linux-zone.com"
  launch_configuration = "${aws_launch_configuration.nodes-craft-k8s-linux-zone-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-craft-k8s-linux-zone-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "craft-k8s.linux-zone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.craft-k8s.linux-zone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-craft-k8s-linux-zone-com" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "a.etcd-events.craft-k8s.linux-zone.com"
    "k8s.io/etcd/events"                             = "a/a"
    "k8s.io/role/master"                             = "1"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-craft-k8s-linux-zone-com" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "a.etcd-main.craft-k8s.linux-zone.com"
    "k8s.io/etcd/main"                               = "a/a"
    "k8s.io/role/master"                             = "1"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-craft-k8s-linux-zone-com" {
  name = "masters.craft-k8s.linux-zone.com"
  role = "${aws_iam_role.masters-craft-k8s-linux-zone-com.name}"
}

resource "aws_iam_instance_profile" "nodes-craft-k8s-linux-zone-com" {
  name = "nodes.craft-k8s.linux-zone.com"
  role = "${aws_iam_role.nodes-craft-k8s-linux-zone-com.name}"
}

resource "aws_iam_role" "masters-craft-k8s-linux-zone-com" {
  name               = "masters.craft-k8s.linux-zone.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.craft-k8s.linux-zone.com_policy")}"
}

resource "aws_iam_role" "nodes-craft-k8s-linux-zone-com" {
  name               = "nodes.craft-k8s.linux-zone.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.craft-k8s.linux-zone.com_policy")}"
}

resource "aws_iam_role_policy" "masters-craft-k8s-linux-zone-com" {
  name   = "masters.craft-k8s.linux-zone.com"
  role   = "${aws_iam_role.masters-craft-k8s-linux-zone-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.craft-k8s.linux-zone.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-craft-k8s-linux-zone-com" {
  name   = "nodes.craft-k8s.linux-zone.com"
  role   = "${aws_iam_role.nodes-craft-k8s-linux-zone-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.craft-k8s.linux-zone.com_policy")}"
}

resource "aws_internet_gateway" "craft-k8s-linux-zone-com" {
  vpc_id = "${aws_vpc.craft-k8s-linux-zone-com.id}"

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "craft-k8s.linux-zone.com"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-craft-k8s-linux-zone-com-20db74c3976785b88740918299c1cf70" {
  key_name   = "kubernetes.craft-k8s.linux-zone.com-20:db:74:c3:97:67:85:b8:87:40:91:82:99:c1:cf:70"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.craft-k8s.linux-zone.com-20db74c3976785b88740918299c1cf70_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-craft-k8s-linux-zone-com" {
  name_prefix                 = "master-us-east-1a.masters.craft-k8s.linux-zone.com-"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-craft-k8s-linux-zone-com-20db74c3976785b88740918299c1cf70.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-craft-k8s-linux-zone-com.id}"
  security_groups             = ["${aws_security_group.masters-craft-k8s-linux-zone-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.craft-k8s.linux-zone.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-craft-k8s-linux-zone-com" {
  name_prefix                 = "nodes.craft-k8s.linux-zone.com-"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-craft-k8s-linux-zone-com-20db74c3976785b88740918299c1cf70.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-craft-k8s-linux-zone-com.id}"
  security_groups             = ["${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.craft-k8s.linux-zone.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.craft-k8s-linux-zone-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.craft-k8s-linux-zone-com.id}"
}

resource "aws_route_table" "craft-k8s-linux-zone-com" {
  vpc_id = "${aws_vpc.craft-k8s-linux-zone-com.id}"

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "craft-k8s.linux-zone.com"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
    "kubernetes.io/kops/role"                        = "public"
  }
}

resource "aws_route_table_association" "us-east-1a-craft-k8s-linux-zone-com" {
  subnet_id      = "${aws_subnet.us-east-1a-craft-k8s-linux-zone-com.id}"
  route_table_id = "${aws_route_table.craft-k8s-linux-zone-com.id}"
}

resource "aws_security_group" "masters-craft-k8s-linux-zone-com" {
  name        = "masters.craft-k8s.linux-zone.com"
  vpc_id      = "${aws_vpc.craft-k8s-linux-zone-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "masters.craft-k8s.linux-zone.com"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_security_group" "nodes-craft-k8s-linux-zone-com" {
  name        = "nodes.craft-k8s.linux-zone.com"
  vpc_id      = "${aws_vpc.craft-k8s-linux-zone-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "nodes.craft-k8s.linux-zone.com"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-craft-k8s-linux-zone-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-craft-k8s-linux-zone-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1a-craft-k8s-linux-zone-com" {
  vpc_id            = "${aws_vpc.craft-k8s-linux-zone-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-1a"

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "us-east-1a.craft-k8s.linux-zone.com"
    SubnetType                                       = "Public"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
    "kubernetes.io/role/elb"                         = "1"
  }
}

resource "aws_vpc" "craft-k8s-linux-zone-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "craft-k8s.linux-zone.com"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "craft-k8s-linux-zone-com" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                = "craft-k8s.linux-zone.com"
    Name                                             = "craft-k8s.linux-zone.com"
    "kubernetes.io/cluster/craft-k8s.linux-zone.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "craft-k8s-linux-zone-com" {
  vpc_id          = "${aws_vpc.craft-k8s-linux-zone-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.craft-k8s-linux-zone-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
