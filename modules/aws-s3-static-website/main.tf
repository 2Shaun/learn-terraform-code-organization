resource "random_pet" "petname" {
  length    = 3
  separator = "-"
}

resource "aws_s3_bucket" "environment" {
  for_each = toset(var.environments) 
  bucket = "${each.key}-${random_pet.petname.id}"
  acl    = "public-read"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${each.key}-${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  force_destroy = true
}

resource "aws_s3_bucket_object" "environment" {
  for_each     = aws_s3_bucket.environment
  acl          = "public-read"
  key          = "index.html"
  bucket       = each.value.id
  content      = file("${path.root}/assets/index.html")
  content_type = "text/html"

}