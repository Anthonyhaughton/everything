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


# This block is needed to make the bucket fully public but for some reason I keep getting access denied and it looks
# like the same is happeneing to others online, Not sure of the fix yet so adding policy in console.

# resource "aws_s3_bucket_policy" "s3_GetObj" {
#   bucket = aws_s3_bucket.s3_site.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Id      = "GetObject"
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = ["s3:GetObject"]
#         Resource  = "${aws_s3_bucket.s3_site.arn}/*"
#       },
#     ]
#   })
# }

resource "aws_s3_bucket_public_access_block" "public_s3" {
  bucket = aws_s3_bucket.s3_site.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.s3_site.id
  versioning_configuration {
    status = "Enabled"
  }
}


