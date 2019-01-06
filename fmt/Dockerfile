FROM golang:1.11

LABEL "com.github.actions.name"="go fmt"
LABEL "com.github.actions.description"="Run go fmt"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/sjkaliski/go-github-actions"
LABEL "homepage"="https://github.com/sjkaliski/go-github-actions"
LABEL "maintainer"="Steve Kaliski <sjkaliski@gmail.com>"

RUN apt-get update
RUN apt-get install -y jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
