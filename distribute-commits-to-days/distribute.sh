#!/bin/bash

# Get the total number of commits
total_commits=$(git rev-list --count HEAD)

# Get the date of the most recent commit in Unix timestamp format
most_recent_date=$(git show -s --format=%ct HEAD)

# Loop through each commit from the oldest to the most recent
for i in $(seq $total_commits -1 0); do
    # Get the commit hash for the current commit
    commit_hash=$(git rev-list --max-count=1 HEAD~$i)

    # Calculate the date for this commit
    commit_date=$(date -d "@$((most_recent_date - i * 86400))" +%Y-%m-%d)

    # Generate a random hour, minute, and second
    random_hour=$(printf "%02d" $((RANDOM % 24)))
    random_minute=$(printf "%02d" $((RANDOM % 60)))
    random_second=$(printf "%02d" $((RANDOM % 60)))

    # Combine the date and the random time
    commit_date="$commit_date $random_hour:$random_minute:$random_second"

    # Checkout to a new branch at the current commit
    git checkout -b temp $commit_hash

    # Amend the commit with the new date
    GIT_COMMITTER_DATE="$commit_date" git commit --amend --no-edit --date "$commit_date"

    # Checkout to the original branch
    git checkout -

    # Rebase the original branch onto the amended commit
    git rebase temp

    # Delete the temporary branch
    git branch -d temp
done