# go fmt

Runs `gofmt`. To learn more about `gofmt`, see the [official docs](https://golang.org/cmd/gofmt/).

```hcl
action "gofmt" {
  uses    = "sjkaliski/go-github-actions/fmt@v0.4.0"
  needs   = "previous-action"
  secrets = ["GITHUB_TOKEN"]

  env {
    GO_WORKING_DIR = "./path/to/go/files"
    GO_IGNORE_DIRS = "./vendor"
  }
}
```
