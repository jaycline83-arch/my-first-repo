#!/bin/bash
# Auto-detect newest folder and push to GitHub Pages portfolio

# === Start SSH agent and add key ===
eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/ssh-key-private >/dev/null

# === Pull remote changes safely ===
git pull origin main --rebase

# === Detect newest folder (excluding .git etc.) ===
PROJECT_NAME=$(find . -maxdepth 1 -type d ! -name ".git" ! -name "." | sort -r | head -n 1 | sed 's|^\./||')
DESCRIPTION="$PROJECT_NAME"
COMMIT_MESSAGE="Add $PROJECT_NAME"

# === Update homepage if a new project is detected ===
if [ ! -z "$PROJECT_NAME" ]; then
  sed -i "/<!-- PROJECT-LIST-END -->/i \  <li><a href=\"$PROJECT_NAME/\">$PROJECT_NAME</a> – $DESCRIPTION</li>" index.html
fi

# === Stage all changes ===
git add .

# === Commit changes ===
git commit -m "$COMMIT_MESSAGE"

# === Push to GitHub ===
git push origin main