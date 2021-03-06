FROM golang:1.9.2
MAINTAINER trevor.pounds@gmail.com

WORKDIR $GOPATH/src/github.com/hashicorp/terraform

RUN git clone https://github.com/hashicorp/terraform.git . && \
    git checkout v0.9.11 && \
    make quickdev

WORKDIR /terraform/templates

ENTRYPOINT ["terraform"]
CMD ["help"]
