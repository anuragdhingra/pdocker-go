# pdocker-go

This repo is the basic implementation of containerizing a golang app via docker using private repos as
import packages. The problem we encounter is to provide the required ssh_key while fetching these packages using `go get` to 
containerize them. You can do it by adding the following to your Dockerfile:

```bash
RUN mkdir -p /root/.ssh && \
    echo "$SSH_KEY" > /root/.ssh/id_rsa && \
    chmod 0600 /root/.ssh/id_rsa && \
    eval `ssh-agent` && \
    ssh-add /root/.ssh/id_rsa && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts && \
    echo "[url \"ssh://git@github.com/\"]\n\tinsteadOf = https://github.com/" >> /root/.gitconfig && \
    echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
```

### Steps to follow:
- Get the project using `go get` :
```bash
go get github.com/anuragdhingra/pdocker-go
```
- Run make command, if you have default github ssh_key_path as `~/.ssh/id_rsa`:
```bash
make build-dev
```
Use the argument optional argument `ssh_key_path` in case of custom paths:
```bash
make build-dev ssh_key_path=~/.ssh/${SSH_KEY_FILENAME}
```
*NOTE*: Make sure you have the same public part of the key added to your github account [here](https://github.com/settings/keys).

- The make command will use your ssh_key make authenticated requests inside the
container environment, spin up an elasticsearch instance, a mysql instance and once both of them are ready will spin
an instance of your application which will try to connect to the former spun containers.
Using the [wait-for-it.sh](https://github.com/vishnubob/wait-for-it) script to coordinate the containers.




