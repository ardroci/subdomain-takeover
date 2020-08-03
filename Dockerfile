# pull base image
FROM alpine

# get dependencies
RUN apk update && \
    apk add --no-cache git make musl-dev go

# configure environment variables
ENV PATH="/usr/local/go/bin:$PATH"
ENV GOPATH=/opt/go/
ENV PATH=$PATH:$GOPATH/bin

# create wirk directory
WORKDIR /home

# get subjack
RUN go get github.com/haccer/subjack

# run subjack
ENTRYPOINT subjack -a -w domains.txt -t 100 -timeout 30 -o results.txt -ssl && \ 
           sed -i.bak '/\[Not Vulnerable\]/d' ./results.txt 
