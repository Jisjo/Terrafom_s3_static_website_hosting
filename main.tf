#Creating s3 bucket
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket



resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket
  acl    = "public-read"
  policy = templatefile("policy.json", {bucketName=var.bucket})
  website {
    index_document = "index.html"
    error_document = "error.html"

    
  }
  tags = {
    Name        = "s3-${var.bucket}"
  }
}

#uploading mutiple files using module templete file


resource "aws_s3_bucket_object" "static_files" {
  for_each = module.template_files.files
  bucket       = aws_s3_bucket.my_bucket.id
  key          = each.key
  content_type = each.value.content_type
  source  = each.value.source_path
  content = each.value.content
  etag = each.value.digests.md5
}


# output showing the s3 website URL
output "website-url" {
    value = aws_s3_bucket.my_bucket.website_endpoint
}