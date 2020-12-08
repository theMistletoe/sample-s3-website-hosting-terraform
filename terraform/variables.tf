variable "bucket_name" {
  type = map(string)
  default = {
    dev  = "mistletoe-dev-website-hosting.aasdhaishdaisdnoaihsa9.com"
    prod = "mistletoe-prod-website-hosting.aasdhaishdaisdnoaihsa9.com"
  }
}