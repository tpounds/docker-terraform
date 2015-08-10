FROM golang:1.4.2
MAINTAINER trevor.pounds@gmail.com

RUN mkdir -p $GOPATH/src/github.com/hashicorp/terraform && \
    cd $GOPATH/src/github.com/hashicorp/terraform && \
    git clone https://github.com/hashicorp/terraform.git . && \
    git checkout v0.6.2 && \
    make updatedeps && \
    make dev

WORKDIR /terraform/config

ENTRYPOINT ["terraform"]