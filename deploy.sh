#!/bin/sh
# Run command: ./deploy.sh "Your optional commit message"

# If a command fails then the deploy stops
set -e

# Stash local change
git stash

# Pull remote changes which should just be new comments
git pull origin main

# Add back stashed changes and clear stash
git stash pop

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# copy staticman to deploy folder
cp staticman.yml public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin main
