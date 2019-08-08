require 'awspec'
require 'aws-sdk'


environment = "test-kitchen"
project = "test-kitchen"
costcode = "test-kitchen"
ecr_name = "foo"
ecr_image_expiry = "10"
ecr_tag_status = "untagged"


describe ecr_repository(ecr_name) do
    it {should exist}
end