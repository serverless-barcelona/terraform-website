module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "www.${var.domain_name}"

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    status = true
  }

  #Bucket policies
  attach_policy                         = true
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # ObjectOwner
  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  # policy = jsonencode({
  #   Statement = [
  #       {
  #         Sid = "PublicReadGetObject",
  #         Effect = "Allow",
  #         Principal =  "*",
  #         Action =  "s3:GetObject",
  #         Resource = "arn:aws:s3:::${var.environment}-platform-${var.tenant}-tmp/public/*"
  #       }
  #   ]
  # })

  # website = {
  #   index_document = "index.html"
  #   error_document = "error.html"
  # }

}

# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "denyOutdatedTLS",
#             "Effect": "Deny",
#             "Principal": "*",
#             "Action": "s3:*",
#             "Resource": [
#                 "arn:aws:s3:::www.serverless-barcelona.com/*",
#                 "arn:aws:s3:::www.serverless-barcelona.com"
#             ],
#             "Condition": {
#                 "NumericLessThan": {
#                     "s3:TlsVersion": "1.2"
#                 }
#             }
#         },
#         {
#             "Sid": "denyInsecureTransport",
#             "Effect": "Deny",
#             "Principal": "*",
#             "Action": "s3:*",
#             "Resource": [
#                 "arn:aws:s3:::www.serverless-barcelona.com/*",
#                 "arn:aws:s3:::www.serverless-barcelona.com"
#             ],
#             "Condition": {
#                 "Bool": {
#                     "aws:SecureTransport": "false"
#                 }
#             }
#         },
#         {
#             "Sid": "AllowCloudFrontServicePrincipal",
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "cloudfront.amazonaws.com"
#             },
#             "Action": "s3:GetObject",
#             "Resource": "arn:aws:s3:::www.serverless-barcelona.com/*",
#             "Condition": {
#                 "StringEquals": {
#                     "AWS:SourceArn": "arn:aws:cloudfront::849760155312:distribution/E3481VR8KOVWEW"
#                 }
#             }
#         }
#     ]
# }