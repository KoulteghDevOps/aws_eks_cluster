terraform {
  backend "local" {
    path = "/opt/eks-cluster.tfstate"
  }
}

# Configure the AWS provide

provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create IAM roles for the EKS clusters

resource "aws_iam_role" "eks_cluster_role_1" {
  name = "eks-cluster-role-1"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "eks_cluster_role_2" {
  name = "eks-cluster-role-2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create IAM policies for the EKS clusters
resource "aws_iam_policy" "eks_cluster_policy_1" {
  name = "eks-cluster-policy-1"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:CreateCluster",
        "eks:DescribeCluster"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "eks_cluster_policy_2" {
  name = "eks-cluster-policy-2"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:CreateCluster",
        "eks:DescribeCluster"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach IAM policies to IAM roles
resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy_attachment_1" {
  role       = aws_iam_role.eks_cluster_role_1.name
#  policy_arn = aws_iam_policy.eks_cluster_policy_1.arn
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy_attachment_2" {
  role       = aws_iam_role.eks_cluster_role_2.name
#  policy_arn = aws_iam_policy.eks_cluster_policy_2.arn
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
#
#resource "aws_iam_role" "eks_cluster_role_1" {
#  name = "eks-cluster-role-1"
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "eks.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole"
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy_attachment_1" {
#  role       = aws_iam_role.eks_cluster_role_1.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"  # Add this line
#}
#
#resource "aws_iam_role" "eks_cluster_role_2" {
#  name = "eks-cluster-role-2"
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "eks.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole"
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy_attachment_2" {
#  role       = aws_iam_role.eks_cluster_role_2.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"  # Add this line
#}


# Create the first EKS cluster
resource "aws_eks_cluster" "eks_cluster_1" {
  name           = "my-eks-cluster-1"
  role_arn       = aws_iam_role.eks_cluster_role_1.arn
  version        = "1.27"  # Replace with the desired EKS version
  vpc_config {
    subnet_ids = ["subnet-07bd1e88fbed5ae3d", "subnet-0ddc9169c859b06a4"]  # Replace with your desired subnet IDs
  }
}

resource "aws_eks_cluster" "eks_cluster_2" {
  name           = "my-eks-cluster-2"
  role_arn       = aws_iam_role.eks_cluster_role_2.arn
  version        = "1.27"  # Replace with the desired EKS version
  vpc_config {
    subnet_ids = ["subnet-0956459633e02b08c", "subnet-09c7f74ab8059ccb4"]  # Replace with your desired subnet IDs
  }
}

