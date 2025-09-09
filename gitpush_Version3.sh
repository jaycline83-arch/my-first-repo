#!/bin/bash

# This script checks if all files and folders (recursively) are the same between local and remote (origin/main).

# Fetch the latest remote info (does not alter your working tree)
git fetch origin main

# Create a temporary branch tracking the remote main
TMP_BRANCH=__tmp_remote_main_check__

# Save your current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Remove temp branch if it already exists
git branch -D $TMP_BRANCH 2>/dev/null

# Create new temp branch pointing to origin/main
git branch $TMP_BRANCH origin/main

# Show difference between your current branch and the remote
echo "Comparing local $CURRENT_BRANCH to remote main (origin/main):"
echo "------------------------------------------------------------"
git diff --name-status $TMP_BRANCH..$CURRENT_BRANCH

# Show files present only locally
echo ""
echo "Files present only in your local branch:"
git ls-files --others --exclude-standard

# Optionally, show untracked folders (find empty directories)
echo ""
echo "Empty directories not tracked by git (if any):"
find . -type d -empty -not -path "./.git/*" -not -path "./.git"

# Clean up temporary branch
git branch -D $TMP_BRANCH

echo ""
echo "Done. If nothing is listed above, your local and remote are in sync!"
