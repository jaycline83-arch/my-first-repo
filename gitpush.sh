#!/bin/bash
# Git push script for portfolio (auto pull, update homepage, commit, push)

# === Input arguments ===
PROJECT_NAME=$1
DESCRIPTION=$2
COMMIT_MESSAGE=$3

# === Defaults ===
if [ -z "$DESCRIPTION" ]; then
  DESCRIPTION="New project"
fi

if [ -z "$COMMIT_MESSAGE" ]; then
  COMMIT_MESSAGE="Add $PROJECT_NAME"
fi

# === Start SSH agent and add key ===
eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/ssh-key-private >/dev/null

# === Pull remote changes safely ===
git pull origin main --rebase

# === Update homepage if a project name is provided ===
if [ ! -z "$PROJECT_NAME" ]; then
  sed -i "/<!-- PROJECT-LIST-END -->/i \  <li><a href=\"$PROJECT_NAME/\">$PROJECT_NAME</a> – $DESCRIPTION</li>" index.html
fi

# === Stage all changes ===
git add .

# === Commit changes ===
git commit -m "$COMMIT_MESSAGE"

# === Push to GitHub ===
git push origin main

