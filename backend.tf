terraform {
  cloud {
    organization = "belgaied"

    workspaces {
      name = "tf-rancher-268-ec2"
    }
  }
}