output "static_website_url" {
  value = aws_s3_bucket_website_configuration.web.website_endpoint
}