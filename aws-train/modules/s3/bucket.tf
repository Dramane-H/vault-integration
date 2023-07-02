resource "aws_s3_bucket" "example" {
  bucket = "EmployePhotoBucket"

  tags = {
    Name        = "employeeDir"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_acl" "example" {

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}