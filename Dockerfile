FROM golang:1.7.5
MAINTAINER trevor.pounds@gmail.com

WORKDIR $GOPATH/src/github.com/hashicorp/terraform

RUN git clone https://github.com/hashicorp/terraform.git . && \
    git checkout v0.8.5 && \
    make quickdev

WORKDIR /terraform/templates

ENTRYPOINT ["terraform"]
CMD ["help"]
