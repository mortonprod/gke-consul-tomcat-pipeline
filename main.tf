# provider "google" {
#   credentials = "${file("./creds/serviceaccount.json")}"
#   project     = "kubernetes-consul-experiment"
#   region      = "europe-west1"
# }

# resource "google_container_cluster" "primary" {
#   name     = "my-gke-cluster"
#   location = "europe-west1-b"

#   # We can't create a cluster with no node pool defined, but we want to only use
#   # separately managed node pools. So we create the smallest possible default
#   # node pool and immediately delete it.
#   # remove_default_node_pool = true
#   initial_node_count = 3

#   master_auth {
#     username = ""
#     password = ""

#     client_certificate_config {
#       issue_client_certificate = false
#     }
#   }
# }

# resource "google_container_node_pool" "primary_preemptible_nodes" {
#   name       = "my-node-pool"
#   location   = "europe-west1-b"
#   cluster            = "${google_container_cluster.primary.name}"
#   node_count = 3

#   node_config {
#     preemptible  = true
#     machine_type = "n1-standard-1"

#     metadata = {
#       disable-legacy-endpoints = "true"
#     }

#     oauth_scopes = [
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#     ]
#   }
# }


#### AWS 

provider "aws" {
  region = "eu-west-2"
}

data "aws_ami" "aws_ebs" {
  most_recent = true
  owners           = ["self"]
  filter {
    name   = "name"
    values = ["amazon-ebs-vagrant-kubernetes-*"]
  }
}
resource "aws_instance" "instance" {
  ami           = "${data.aws_ami.aws_ebs.id}"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  # Security group for access to my computer ip.
  # Need to update this in AWS console if ip changes
  vpc_security_group_ids = ["sg-0ee5850b39c05e40b"]
  tags = {
    Name = "Vagrant Instance"
  }
  key_name = "aws_personal"
}

# resource "aws_default_security_group" "default_security_group" {
#   vpc_id = "${aws_default_vpc.default_vpc.id}"

#   ingress {
#     protocol  = "tcp"
#     from_port = 22
#     to_port   = 22
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }





# resource "aws_iam_role" "eks-example" {
#   name = "terraform-eks-demo"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "eks-example-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = "${aws_iam_role.eks-example.name}"
# }

# resource "aws_iam_role_policy_attachment" "eks-example-AmazonEKSServicePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = "${aws_iam_role.eks-example.name}"
# }

# resource "aws_eks_cluster" "demo" {
#   name            = "terraform-eks-demo"
#   role_arn        = "${aws_iam_role.eks-example.arn}"

#     vpc_config {
#     subnet_ids = var.subnet_ids
#   }

#   depends_on = [
#     "aws_iam_role_policy_attachment.eks-example-AmazonEKSClusterPolicy",
#     "aws_iam_role_policy_attachment.eks-example-AmazonEKSServicePolicy",
#   ]
# }

# locals {
#   kubeconfig = <<KUBECONFIG


# apiVersion: v1
# clusters:
# - cluster:
#     server: ${aws_eks_cluster.demo.endpoint}
#     certificate-authority-data: ${aws_eks_cluster.demo.certificate_authority.0.data}
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: aws
#   name: aws
# current-context: aws
# kind: Config
# preferences: {}
# users:
# - name: aws
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: heptio-authenticator-aws
#       args:
#         - "token"
#         - "-i"
#         - "${var.cluster_name}"
# KUBECONFIG
# }