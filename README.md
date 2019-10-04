# go-github-actions

A collection of [GitHub Actions](https://github.com/features/actions) for use in [Golang](https://golang.org/) projects.

## Actions

Currently there is support for `gofmt` and `golint`. If triggered by a `pull_request`, any failure will be posted back to the PR as a comment.

### gofmt

Runs `gofmt` on files in the directory. Fails if any file is not properly formatted.

```hcl
workflow "Go" {
  on = "pull_request"
  resolves = ["gofmt"]
}

action "gofmt" {
  uses    = "sjkaliski/go-github-actions/fmt@v0.5.0"
  needs   = "previous-action"
  secrets = ["GITHUB_TOKEN"]

  env {
    GO_WORKING_DIR = "./path/to/go/files"
    GO_IGNORE_DIRS = "./vendor"
  }
}
```

To learn more about `gofmt`, visit the [official docs](https://golang.org/cmd/gofmt/).

### golint

Runs `golint` on files in the directory. Fails if any file fails lint checks.

```hcl
workflow "Go" {
  on = "pull_request"
  resolves = ["golint"]
}

action "golint" {
  uses    = "sjkaliski/go-github-actions/lint@v0.5.0"
  needs   = "previous-action"
  secrets = ["GITHUB_TOKEN"]

  env {
    GO_WORKING_DIR = "./path/to/go/files"
    GO_LINT_PATHS  = "./pkg/... ./cmd/..."
  }
}
```

To learn more about `golint`, see the [golint repository](https://github.com/golang/lint/).
