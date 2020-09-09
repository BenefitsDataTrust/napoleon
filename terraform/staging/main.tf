provider "random" {}

resource "random_string" "some_password" {
  length           = 15
  special          = true
  override_special = "/@\" "
}

resource "random_id" "some_id" {
  byte_length = "64"
}
