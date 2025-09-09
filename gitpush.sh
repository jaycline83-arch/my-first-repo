#!/bin/bash
# Quick Git push script for portfolio with automatic project links

PROJECT_NAME=$1
DESCRIPTION=$2
COMMIT_MESSAGE=$3
# Default description if none provided
if [ -z "$DESCRIPTION" ]; then
  DESCRIPTION="New project"
fi

# Default commit message if none provided
if [ -z "$COMMIT_MESSAGE" ]; then
  COMMIT_MESSAGE="Add $PROJECT_NAME"
fi
if [ ! -z "$PROJECT_NAME" ]; then
  sed -i "/<!-- PROJECT-LIST-END -->/i \  <li><a href=\"$PROJECT_NAME/\">$PROJECT_NAME</a> – $DESCRIPTION</li>" index.html
fi
git add .
git commit -m "$COMMIT_MESSAGE"
git push
