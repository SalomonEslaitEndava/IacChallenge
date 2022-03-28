terraform {
  backend "remote" {
    hostname     = var.hostname # "app.terraform.io"
    organization = var.organization # "salomon"

    workspaces {
      name = var.workspacename #"iacChallenge"
    }
  }
}