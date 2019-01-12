# go-github-actions

A collection of [GitHub Actions](https://github.com/features/actions) for use in [Golang](https://golang.org/) projects.

## Actions

### gofmt

Runs `gofmt` on files in the directory. Fails if any file is not properly formatted.

```hcl
action "gofmt" {
  uses    = "sjkaliski/go-github-actions/fmt@v0.1.0"
  needs   = "previous-action"
  secrets = ["GITHUB_TOKEN"]

  env {
    GO_WORKING_DIR = "./path/to/go/files"
  }
}
```

To learn more about `gofmt`, visit the [official docs](https://golang.org/cmd/gofmt/).

### golint

Runs `golint` on files in the directory. Failes if any file fails lint checks.

```hcl
action "golint" {
  uses    = "sjkaliski/go-github-actions/lint@v0.1.0"
  needs   = "previous-action"
  secrets = ["GITHUB_TOKEN"]

  env {
    GO_WORKING_DIR = "./path/to/go/files"
    GO_LINT_PATHS = "./pkg/... ./cmd/..."
  }
}
```

To learn more about `golint`, see the [golint repository](https://github.com/golang/lint/).
