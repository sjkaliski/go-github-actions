#!/bin/sh
set -e

cd "${GO_WORKING_DIR:-.}"

# Check if any files are not formatted.
set +e
test -z "$(gofmt -l -d -e $(find . -type f -iname '*.go'))"
SUCCESS=$?
set -e

# Exit if `go fmt` passes.
if [ $SUCCESS -eq 0 ]; then
  exit 0
fi

# Get list of unformatted files.
set +e
FILES=$(sh -c "gofmt -l . $*" 2>&1)
echo "$FILES"
set -e

# Iterate through each unformatted file.
OUTPUT=""
for file in $FILES; do
DIFF=$(gofmt -d -e "$file")
OUTPUT="$OUTPUT
\`$file\`

\`\`\`diff
$DIFF
\`\`\`
"
done

# Post results back as comment.
COMMENT="#### \`go fmt\`
$OUTPUT
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)

if [ "COMMENTS_URL" != null ]; then
  curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null
fi

exit $SUCCESS
