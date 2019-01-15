#!/bin/sh
set -e

cd "${GO_WORKING_DIR:-.}"

# Check if lint fails on any files.
set +e
OUTPUT="$(golint -set_exit_status ${GO_LINT_PATHS:-./...})"
SUCCESS=$?
set -e

# Exit if `golint` passes.
if [ $SUCCESS -eq 0 ]; then
  exit 0
fi

# Post results back as comment.
COMMENT="#### \`golint\`
\`\`\`
$OUTPUT
\`\`\`
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
