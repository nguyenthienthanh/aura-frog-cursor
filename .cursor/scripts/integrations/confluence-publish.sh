#!/bin/bash

# Confluence Publish Script
# Publishes documentation to Confluence
# Usage: ./confluence-publish.sh <SPACE_KEY> <PAGE_TITLE> <CONTENT_FILE> [PARENT_PAGE_ID]

set -e

# Load environment variables
if [ -f .envrc ]; then
    source .envrc
elif [ -f .env ]; then
    export $(cat .env | grep -v "^#" | xargs)
fi

# Check required vars
if [ -z "$CONFLUENCE_EMAIL" ] || [ -z "$CONFLUENCE_API_TOKEN" ]; then
    echo "Error: Confluence credentials not configured" >&2
    echo "Set CONFLUENCE_EMAIL and CONFLUENCE_API_TOKEN in .envrc" >&2
    exit 1
fi

if [ -z "$CONFLUENCE_URL" ]; then
    echo "Error: CONFLUENCE_URL not configured" >&2
    exit 1
fi

# Arguments
SPACE_KEY="${1:-$CONFLUENCE_SPACE_KEY}"
PAGE_TITLE="$2"
CONTENT_FILE="$3"
PARENT_PAGE_ID="$4"

if [ -z "$SPACE_KEY" ] || [ -z "$PAGE_TITLE" ] || [ -z "$CONTENT_FILE" ]; then
    echo "Usage: $0 <SPACE_KEY> <PAGE_TITLE> <CONTENT_FILE> [PARENT_PAGE_ID]"
    echo ""
    echo "Arguments:"
    echo "  SPACE_KEY      - Confluence space key (e.g., DEV, TECH)"
    echo "  PAGE_TITLE     - Title of the page to create/update"
    echo "  CONTENT_FILE   - Path to markdown file to publish"
    echo "  PARENT_PAGE_ID - (Optional) Parent page ID for nested pages"
    echo ""
    echo "Examples:"
    echo "  $0 'DEV' 'API Documentation' 'docs/api.md'"
    echo "  $0 'TECH' 'Feature Summary' 'summary.md' '123456'"
    exit 1
fi

if [ ! -f "$CONTENT_FILE" ]; then
    echo "Error: File not found: $CONTENT_FILE" >&2
    exit 1
fi

echo "Publishing to Confluence..."
echo "   Space: $SPACE_KEY"
echo "   Page: $PAGE_TITLE"
echo "   File: $CONTENT_FILE"

# Read and escape content for JSON
CONTENT=$(cat "$CONTENT_FILE")

# Basic Markdown to Confluence storage format conversion
# Note: For complex formatting, consider using pandoc
convert_markdown_to_confluence() {
    local input="$1"

    # Convert headers
    echo "$input" | \
        sed 's/^# \(.*\)/<h1>\1<\/h1>/g' | \
        sed 's/^## \(.*\)/<h2>\1<\/h2>/g' | \
        sed 's/^### \(.*\)/<h3>\1<\/h3>/g' | \
        sed 's/^#### \(.*\)/<h4>\1<\/h4>/g' | \
        # Convert bold
        sed 's/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g' | \
        # Convert italic
        sed 's/\*\([^*]*\)\*/<em>\1<\/em>/g' | \
        # Convert code blocks
        sed 's/```\([a-z]*\)/<ac:structured-macro ac:name="code"><ac:parameter ac:name="language">\1<\/ac:parameter><ac:plain-text-body><!\[CDATA\[/g' | \
        sed 's/```/\]\]><\/ac:plain-text-body><\/ac:structured-macro>/g' | \
        # Convert inline code
        sed 's/`\([^`]*\)`/<code>\1<\/code>/g' | \
        # Convert line breaks
        sed 's/$/\n/g'
}

CONFLUENCE_CONTENT=$(convert_markdown_to_confluence "$CONTENT")

# Escape for JSON
ESCAPED_CONTENT=$(echo "$CONFLUENCE_CONTENT" | jq -Rs .)

# Check if page exists
echo "Checking for existing page..."
EXISTING_PAGE=$(curl -s \
    -u "$CONFLUENCE_EMAIL:$CONFLUENCE_API_TOKEN" \
    -H "Accept: application/json" \
    "$CONFLUENCE_URL/rest/api/content?spaceKey=$SPACE_KEY&title=$(echo "$PAGE_TITLE" | jq -sRr @uri)")

PAGE_ID=$(echo "$EXISTING_PAGE" | jq -r '.results[0].id // empty')

if [ -n "$PAGE_ID" ]; then
    # Update existing page
    echo "Found existing page (ID: $PAGE_ID), updating..."

    # Get current version
    CURRENT_VERSION=$(echo "$EXISTING_PAGE" | jq -r '.results[0].version.number')
    NEW_VERSION=$((CURRENT_VERSION + 1))

    RESPONSE=$(curl -s -w "\n%{http_code}" \
        -X PUT \
        -H "Content-Type: application/json" \
        -u "$CONFLUENCE_EMAIL:$CONFLUENCE_API_TOKEN" \
        -d "{
            \"id\": \"$PAGE_ID\",
            \"type\": \"page\",
            \"title\": \"$PAGE_TITLE\",
            \"space\": {\"key\": \"$SPACE_KEY\"},
            \"version\": {\"number\": $NEW_VERSION},
            \"body\": {
                \"storage\": {
                    \"value\": $ESCAPED_CONTENT,
                    \"representation\": \"storage\"
                }
            }
        }" \
        "$CONFLUENCE_URL/rest/api/content/$PAGE_ID")
else
    # Create new page
    echo "Creating new page..."

    # Build JSON payload
    if [ -n "$PARENT_PAGE_ID" ]; then
        ANCESTORS="\"ancestors\": [{\"id\": \"$PARENT_PAGE_ID\"}],"
    else
        ANCESTORS=""
    fi

    RESPONSE=$(curl -s -w "\n%{http_code}" \
        -X POST \
        -H "Content-Type: application/json" \
        -u "$CONFLUENCE_EMAIL:$CONFLUENCE_API_TOKEN" \
        -d "{
            \"type\": \"page\",
            \"title\": \"$PAGE_TITLE\",
            \"space\": {\"key\": \"$SPACE_KEY\"},
            $ANCESTORS
            \"body\": {
                \"storage\": {
                    \"value\": $ESCAPED_CONTENT,
                    \"representation\": \"storage\"
                }
            }
        }" \
        "$CONFLUENCE_URL/rest/api/content")
fi

# Parse response
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "201" ]; then
    PAGE_ID=$(echo "$BODY" | jq -r '.id')
    PAGE_URL="$CONFLUENCE_URL/pages/viewpage.action?pageId=$PAGE_ID"

    echo "Published to Confluence!"
    echo "   Page ID: $PAGE_ID"
    echo "   URL: $PAGE_URL"

    # Create log directory and save response
    mkdir -p .cursor/logs/confluence
    echo "$BODY" > ".cursor/logs/confluence/page-$PAGE_ID.json"

    exit 0
else
    echo "Error: Failed to publish to Confluence (HTTP $HTTP_CODE)" >&2
    echo "$BODY" >&2
    exit 1
fi
