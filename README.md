## docker-terraform
A [Hashicorp Terraform](https://www.terraform.io/) Docker image.

## Building
docker build -t tpounds/terraform:v0.6.2 .

## Running
docker run --volume /path/to/config:/terraform/config tpounds/terraform:v0.6.2 <command> [<args>]
