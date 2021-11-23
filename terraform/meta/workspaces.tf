data "tfe_workspace" "alpha" {
  name         = "candy-alpha"
  organization = "qcgouv"
}

data "tfe_workspace" "beta" {
  name         = "candy-beta"
  organization = "qcgouv"
}

data "tfe_workspace" "dev" {
  name         = "candy-dev"
  organization = "qcgouv"
}

data "tfe_workspace" "test" {
  name         = "candy-test"
  organization = "qcgouv"
}

data "tfe_workspace" "prod" {
  name         = "candy-prod"
  organization = "qcgouv"
}
