terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "salomon"

    workspaces {
      name = "iacChallenge"
    }
  }
}