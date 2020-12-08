terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.18"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

data "aws_iam_policy_document" "website_hosting_s3_policy" {
  statement {
    actions = ["s3:GetObject"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["arn:aws:s3:::${var.bucket_name[terraform.workspace]}/*"]
    sid       = "PublicReadGetObject"
  }
}

resource "aws_s3_bucket" "website_hosting_mistletoe_com_bucket" {
  bucket = var.bucket_name[terraform.workspace]
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_hosting_s3_policy.json

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

output "url" {
  value = aws_s3_bucket.website_hosting_mistletoe_com_bucket.website_endpoint
}