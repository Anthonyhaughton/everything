resource "aws_s3_bucket" "s3_site" {
  bucket = "devhaughton.com"

  tags = {
     Name        = "My bucket"
     Environment = "Dev"
   }
}

resource "aws_s3_object" "file_upload" {
  bucket = aws_s3_bucket.s3_site.id

  for_each = fileset("${path.module}/website", "*")

  key          = each.value
  source       = "website/${each.value}"
  content_type = each.value
}

resource "aws_s3_bucket_public_access_block" "public_s3" {
  bucket = aws_s3_bucket.s3_site.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "s3_GetObj" {
  bucket = aws_s3_bucket.s3_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "GetObject"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.s3_site.arn}/*"
      },
    ]
  })

  # Using depends_on is a good way to force the public access block and policy to be applied one-by-one instead of concurrently
  # Without this the bucket policy block will fail with an Access Denied error.
   depends_on = [ 
    
    aws_s3_bucket_public_access_block.public_s3
  ]
}

resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.s3_site.id
  versioning_configuration {
    status = "Enabled"
  }
}


