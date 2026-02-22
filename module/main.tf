module "dev-infra" {
  source         = "./infra-app"
  env            = "dev"
  bucket_name    = "sdeep21june"
  instance_count = "1"
  instance_type  = "t2.medium"
  ec2_ami_id     = "ami-051a31ab2f4d498f5"
  hash_key       = "studentID"
  dynamodb_table = "dev"
}

module "prd-infra" {
  source         = "./infra-app"
  env            = "prd"
  bucket_name    = "sdeep21june"
  instance_count = "1"
  instance_type  = "t2.large"
  ec2_ami_id     = "ami-051a31ab2f4d498f5"
  hash_key       = "studentID"
  dynamodb_table = "prd"
}

module "stg-infra" {
  source         = "./infra-app"
  env            = "stg"
  bucket_name    = "sdeep21june"
  instance_count = "2"
  instance_type  = "t2.medium"
  ec2_ami_id     = "ami-019715e0d74f695be"
  hash_key       = "studentID"
  dynamodb_table = "stg"
}

