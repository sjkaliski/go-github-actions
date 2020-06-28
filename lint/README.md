# golint

Runs `golint`. To learn more about `golint`, see the [golint repository](https://github.com/golang/lint/).

Use `GO_LINT_PATHS` to specify directories to evaluate. Defaults to `./...`.

```hcl
workflow "Go" {
  on = "pull_request"
  resolves = ["golint"]
}

action "golint" {
  uses    = "sjkaliski/go-github-actions/lint@v1.0.0"
  needs   = "previous-action"
  secrets = ["GITHUB_TOKEN"]

  env {
    GO_WORKING_DIR = "./path/to/go/files"
    GO_LINT_PATHS  = "./pkg/... ./cmd/..."
  }
}
```
