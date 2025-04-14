terraform {
  backend "s3" {
    bucket         = "terraform-backend-bucket-niico"
    key            = "terraform/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    use_lockfile = true
  }
}