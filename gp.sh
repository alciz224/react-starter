#!/bin/bash

# gitpush.sh - A script to simplify git add, commit, and push operations
# Usage: ./gitpush.sh "Your commit message"

# Check if a commit message was provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide a commit message."
    echo "Usage: ./gitpush.sh \"Your commit message\""
    exit 1
fi

# Store the commit message
COMMIT_MESSAGE="$1"

# Add all changes
echo "Adding all changes..."
git add .

# Check if git add was successful
if [ $? -eq 0 ]; then
    echo "Successfully added changes."
else
    echo "Error: Failed to add changes."
    exit 1
fi

# Commit with the provided message
echo "Committing changes with message: \"$COMMIT_MESSAGE\""
git commit -m "$COMMIT_MESSAGE"

# Check if git commit was successful
if [ $? -eq 0 ]; then
    echo "Successfully committed changes."
else
    echo "Error: Failed to commit changes."
    exit 1
fi

# Push to the remote repository
echo "Pushing to origin main..."
git push -u origin main

# Check if git push was successful
if [ $? -eq 0 ]; then
    echo "Successfully pushed changes to origin main."
else
    echo "Error: Failed to push changes to origin main."
    exit 1
fi

echo "All git operations completed successfully!"
