resource "aws_s3_bucket" "sherif_web_bucket838" {
  bucket        = "slade-web-bucket-1234"
  force_destroy = true
  tags = {
    "Name" = "web"
  }
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.sherif_web_bucket838.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.sherif_web_bucket838.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.sherif_web_bucket838.id}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.sherif_web_bucket838.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_object" "website_files" {
  bucket       = aws_s3_bucket.sherif_web_bucket838.id
  key          = "index.html"
  source       = "uploads/index.html"
  content_type = "text/html"
}