module "dev-infra" {
  source         = "./infra-app"
  env            = "prd"
  bucket_name    = "sdeep21june"
  instance_count = "1"
  instance_type  = "t2.medium"
  ec2_ami_id     = "ami-051a31ab2f4d498f5"
  hash_key       = "studentID"
  dynamodb_table = "prd"
  ebs_volume    = "8"
}

