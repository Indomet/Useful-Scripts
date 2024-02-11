#!/bin/bash

# Source folder path (two levels up)
source_folder="../"

# Destination folder path (two levels up, then create a "backup" folder within)
destination_folder="../backup"

# Get today's date in the format YYYY-MM-DD
today=$(date +"%Y-%m-%d_%H:%M:%S")

# Create the destination folder if it doesn't exist
mkdir -p "$destination_folder"

# Iterate through all subdirectories in the source folder
find "$source_folder" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    # Get the name of the current directory
    folder_name=$(basename "$dir")

    # Skip directories with specific names
    if [ "$folder_name" != "exclude_folder1" ] && [ "$folder_name" != "exclude_folder2" ] && [ "$folder_name" != "backup" ]; then
        # Create a new folder name with today's date and the current folder name
        new_folder_name="${today}_${folder_name}"

        # Create the destination folder with the new name within the backup folder
        destination_path="$destination_folder/$new_folder_name"
        mkdir -p "$destination_path"

        # Copy the contents of the current folder to the destination folder
        # Exclude specific files (e.g., readme.md, change_commit_author.sh)
        rsync -a --exclude='readme.md' --exclude='change_commit_author.sh' "$dir"/ "$destination_path"
        echo "Contents of $dir (excluding readme.md and change_commit_author.sh) copied to $destination_path"
    else
        echo "Skipped directory: $dir"
    fi
done

## Clearing any previous cash from previous runs, ensuring a clean state so that 
# the user can run this code multiple times
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD

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