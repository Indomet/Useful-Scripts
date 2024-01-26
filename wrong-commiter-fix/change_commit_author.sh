#!/bin/bash

read -p "Enter your incorrect/old email: " OLD_EMAIL
read -p "Enter your correct/new name: " CORRECT_NAME
read -p "Enter your correct/new email: " CORRECT_EMAIL

echo -e "\nOld Email: $OLD_EMAIL\nCorrect Name: $CORRECT_NAME\nCorrect Email: $CORRECT_EMAIL\n"

read -p "Is this information correct? (y/n): " CONFIRMATION
#${CONFIRMATION,,} converts the input to lowercase
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
