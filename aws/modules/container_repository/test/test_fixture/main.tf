#provider "aws" {
#  region = "eu-west-2"
#}
module "test_ecr" {
  source = "../../"
    costcode          = "${var.costcode}"
    environment       = "${var.environment}"
    project           = "${var.project}"

    ecr_name          = "${var.ecr_name}"
    ecr_image_expiry  = "${var.ecr_image_expiry}"
    ecr_tag_status    = "${var.ecr_tag_status}"
}
