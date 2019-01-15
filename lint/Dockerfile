FROM golang:1.11

LABEL "com.github.actions.name"="golint"
LABEL "com.github.actions.description"="Run golint"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/sjkaliski/go-github-actions"
LABEL "homepage"="https://github.com/sjkaliski/go-github-actions"
LABEL "maintainer"="Steve Kaliski <sjkaliski@gmail.com>"

RUN apt-get update && \
    apt-get install -y jq && \
    go get -u golang.org/x/lint/golint

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
