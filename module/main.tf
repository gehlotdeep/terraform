module "dev-infra" {
  source         = "./infra-app"
  env            = "dev"
  bucket_name    = "sdeep21june"
  instance_count = "1"
  instance_type  = "t2.medium"
  ec2_ami_id     = "ami-0620fe646b4b76c81"
  hash_key       = "studentID"
  dynamodb_table = "dev"
}

module "prd-infra" {
  source         = "./infra-app"
  env            = "prd"
  bucket_name    = "sdeep21june"
  instance_count = "1"
  instance_type  = "t2.large"
  ec2_ami_id     = "ami-075f150fc1ca69e71"
  hash_key       = "studentID"
  dynamodb_table = "prd"
}

module "stg-infra" {
  source         = "./infra-app"
  env            = "stg"
  bucket_name    = "sdeep21june"
  instance_count = "2"
  instance_type  = "t2.medium"
  ec2_ami_id     = "ami-018ff7ece22bf96db"
  hash_key       = "studentID"
  dynamodb_table = "stg"
}

