#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <commit-id> <new-commit-message>"
    exit 1
fi

# Assign command line arguments to variables
commit_id=$1
new_message=$2

# Verify that the commit ID exists
if ! git rev-parse --quiet --verify "$commit_id" > /dev/null; then
    echo "Error: Commit with ID $commit_id not found."
    exit 1
fi

# Save the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Get the original commit date
original_commit_date=$(git show -s --format=%ci $commit_id)

# Checkout the commit to modify
git checkout $commit_id

# Amend the commit with the new message and original commit date
GIT_COMMITTER_DATE="$original_commit_date" git commit --amend -m "$new_message"

# Replace the original commit with the amended commit
git replace $commit_id $(git rev-parse HEAD)

# Push the reference to the replace namespace
git push origin 'refs/replace/*' -f

# Fetch the replace references
git fetch origin 'refs/replace/*:refs/replace/*'

# Return to the original branch
git checkout $current_branch
git filter-branch -f -- --all

echo "Commit message for $commit_id has been changed to: $new_message"

# chmod +x ../change_commit_message.sh
# ../change_commit_message.sh <commit id> "<new commit message>"