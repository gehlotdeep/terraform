# --------------------------------------------------
# S3 Bucket
# --------------------------------------------------
resource "aws_s3_bucket" "my_bucket" {
  bucket = "sdeep21june"
  tags = {
    name = "sdeep21june"
  }
}
