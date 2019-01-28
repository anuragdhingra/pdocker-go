FROM golang:1.11

ARG SSH_KEY

LABEL version="1.0"

RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR /go/src

RUN mkdir -p /root/.ssh && \
    echo "$SSH_KEY" > /root/.ssh/id_rsa && \
    chmod 0600 /root/.ssh/id_rsa && \
    eval `ssh-agent` && \
    ssh-add /root/.ssh/id_rsa && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts && \
    echo "[url \"ssh://git@github.com/\"]\n\tinsteadOf = https://github.com/" >> /root/.gitconfig && \
    echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

RUN go get github.com/anuragdhingra/elasticsearch-go
WORKDIR /go/src/github.com/anuragdhingra/elasticsearch-go

RUN dep ensure

# Remove ssh key
RUN rm /root/.ssh/id_rsa && unset SSH_KEY