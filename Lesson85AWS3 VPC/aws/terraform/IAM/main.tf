provider "aws" {
    region = "us-east-1"
}

variable "user_name" {
    default = "arya-stark"
  
}

# user arya
resource "aws_iam_user" "arya" {
  name = var.user_name
}

# s3 policy
resource "aws_iam_policy" "s3_all" {
  name = "s3_all"
  description = "Allow all actions on all S3 buckets"
  policy = <<EOF
   {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": "*"
      }
    ]
    }
EOF
}

# attach s3 policy to arya
resource "aws_iam_user_policy_attachment" "arya_s3_all" {
  user = aws_iam_user.arya.name
  policy_arn = aws_iam_policy.s3_all.arn
}

# AmazonRDSFullAccess policy
resource "aws_iam_user_policy_attachment" "arya_rds_full" {
  user = aws_iam_user.arya.name
  policy_arn = data.aws_iam_policy.rds_full.arn
  
}

resource "aws_iam_group" "s3FullAccess" {
  name = "s3FullAccess"  
}

resource "aws_iam_group_policy_attachment" "s3FullAccess_attachment" {
  group = aws_iam_group.s3FullAccess.name
  policy_arn = aws_iam_policy.s3_all.arn
  
}

resource "aws_iam_user_group_membership" "arya_s3_all" {
  user = aws_iam_user.arya.name
  groups = [aws_iam_group.s3FullAccess.name]
}


data "aws_iam_policy" "rds_full" {
  name = "AmazonRDSFullAccess"
}


data "aws_iam_user" "instructor" {
  user_name = "instructor"
}

output "instructor_data" {
  value = data.aws_iam_user.instructor
}