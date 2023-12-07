provider "aws" {
  secret_key = var.secret_key
  region = var.region
  access_key = var.access_key

  # Auth Mechanism


  # 3) Shared Credentials
  #profile = "kifeh"

  # 4) Assume role
  #assume_role {
   # role_arn = "arn:aws:iam::453307492034:role/terraform-deployer"
 # }
}

#terraform {
  # bakend block
 # backend "s3" {
  #  bucket = "terraform-test-tfstate237"
   # key    = "batch1/session-6/private_subnet.tfstate"
    #region = "us-east-1"

 # }

#}
