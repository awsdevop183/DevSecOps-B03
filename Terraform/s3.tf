resource "aws_s3_bucket" "state-bucket" {
  bucket = "bunnyops-state"
  region = "us-east-1"

}
