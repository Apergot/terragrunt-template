terraform {
  source = "../../../modules/ecr"
}

inputs = {
  repositories = {
    my_api: {
      "name": "my_api",
      "mutability": "IMMUTABLE",
      "scanOnPush": true,
      "encryptionType": "AES256"
    }
  }
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = "${get_terragrunt_dir()}/../env.hcl"
}