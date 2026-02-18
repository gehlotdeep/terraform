module "dev-infra"{
  source = "./infra-app"
  env = "dev"
  bucket_name = "sdeep21june"
  instance_count = "1"
  instance_type = "t2.medium"
  ec2_ami_id = "ami-018ff7ece22bf96db"
  hash_key = "studentID"
}

module "prd-infra"{
  source = "./infra-app"
  env = "prd"
  bucket_name = "sdeep21june"
  instance_count = "1"
  instance_type = "t2.large"
  ec2_ami_id = "ami-018ff7ece22bf96db"
  hash_key = "studentID"
}

module "stg-infra"{
  source = "./infra-app"
  env = "stg"
  bucket_name = "sdeep21june"
  instance_count = "2"
  instance_type = "t2.medium"
  ec2_ami_id = "ami-018ff7ece22bf96db"
  hash_key = "studentID"
}
