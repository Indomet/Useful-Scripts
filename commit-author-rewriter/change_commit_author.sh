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


# Clearing any previous cash from previous runs, ensuring a clean state so that 
# the user can run this code multiple times
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD

read -p "Enter your incorrect/old email: " OLD_EMAIL
read -p "Enter your correct/new name: " CORRECT_NAME
read -p "Enter your correct/new email: " CORRECT_EMAIL

echo -e "\nOld Email: $OLD_EMAIL\nCorrect Name: $CORRECT_NAME\nCorrect Email: $CORRECT_EMAIL\n"

read -p "Is this information correct? (y/n): " CONFIRMATION
${CONFIRMATION,,} converts the input to lowercase
if [ "${CONFIRMATION,,}" = "y" ]; then 
  git filter-branch --env-filter "
    OLD_EMAIL=\"$OLD_EMAIL\"
    CORRECT_NAME=\"$CORRECT_NAME\"
    CORRECT_EMAIL=\"$CORRECT_EMAIL\"
    if [ \"\$GIT_COMMITTER_EMAIL\" = \"\$OLD_EMAIL\" ]; then
      export GIT_COMMITTER_NAME=\"\$CORRECT_NAME\"
      export GIT_COMMITTER_EMAIL=\"\$CORRECT_EMAIL\"
    fi
    if [ \"\$GIT_AUTHOR_EMAIL\" = \"\$OLD_EMAIL\" ]; then
      export GIT_AUTHOR_NAME=\"\$CORRECT_NAME\"
      export GIT_AUTHOR_EMAIL=\"\$CORRECT_EMAIL\"
    fi
  " --tag-name-filter cat -- --branches --tags

  git push --force --tags origin 'refs/heads/*'
  
  echo "Git history has been updated with the new information."
else
  echo "Operation canceled. Please run the script again with the correct information."
fi
