resource "aws_ecr_repository" "ecr" {
  name = "${var.ecr_name}"
  tags = {
    Environment = "${var.environment}"
    CostCode    = "${var.costcode}"
    Project     = "${var.project}"
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository  = "${aws_ecr_repository.ecr.name}"
  policy      = "${data.template_file.lifecycle_policy.rendered}"
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  repository  = "${aws_ecr_repository.ecr.name}"
  policy      = "${data.template_file.ecr_policy.rendered}"
}


data "template_file" "lifecycle_policy" {
  template = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than ${var.ecr_image_expiry} days",
            "selection": {
                "tagStatus": "${var.ecr_tag_status}",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": ${var.ecr_image_expiry}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

data "template_file" "ecr_policy" {
  template = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}
