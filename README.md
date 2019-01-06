# go-github-actions

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
