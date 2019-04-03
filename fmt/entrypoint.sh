#!/bin/bash
set -e

cd "${GO_WORKING_DIR:-.}"

# Build ignored directories
IGNORED_DIRS=""
if [ -n "${GO_IGNORE_DIRS}" ]; then
  IGNORE_DIRS_ARR=($GO_IGNORE_DIRS)
  for DIR in "${IGNORE_DIRS_ARR[@]}"; do
    # If the directory doesn't end in "/*", add it
    if [[ ! "${DIR}" =~ .*\/\*$ ]]; then
      DIR="${DIR}/*"
    fi
    # Append to our list of directories to ignore
   IGNORED_DIRS+=" -not -path \"${DIR}\""
  done
fi

# Check if any files are not formatted.
set +e
test -z "$(gofmt -l -d -e $(find . -type f -iname '*.go' ${IGNORED_DIRS}))"
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
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
