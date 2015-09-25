## docker-terraform
A [Hashicorp Terraform](https://www.terraform.io/) Docker image.

## Building
```
$ docker build -t tpounds/terraform .
```

## Running
```
$ docker run --volume /path/to/config:/terraform/config tpounds/terraform <command> [<args>]
```
