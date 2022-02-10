variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
  default = "us-east-2"
}

variable "environments" {
  type = list(string)
  default = ["test", "prod"]
}