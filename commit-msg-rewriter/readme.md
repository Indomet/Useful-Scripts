# Change Commit Message Script

## 🛑🛑 WARNING 🛑🛑
* The author of this script bears no responsibility for any harm resulting from its use.
* Running this script implies your agreement to utilize it at your own risk, assuming full responsibility for any ensuing damage.
* The author disclaims any liability for the consequences of employing this script.
* The use of this script should not be associated with or encourage any form of criminal activity.

## Introduction

This Bash script allows you to change the commit message of a specific commit in a Git repository while preserving the original commit date. This can be useful in situations where you need to update commit messages for clarity or consistency.

## Disclaimer
Use this script with caution, especially in collaborative environments. Changing commit messages can affect the commit history and may cause conflicts if others have already pulled the original commits.

## Understand the Implications:

- **Loss of Commit History:** Modifying commit information generates new commits, replacing the old ones and rewriting the commit history.
- **Collaboration Challenges:** Rewriting history may lead to synchronization issues in collaborative environments.
- **Disruption of Integrations:** Modifying commit history can disrupt integrations with tools like CI pipelines, issue trackers, and code review systems.

## Important Notes Before Use

- Ensure that you are on a branch containing the commit you want to modify.
- The script will not work if the branch is set as protected. Make sure you have the necessary permissions.

## Usage

1. **Clone the Repository:**

   ```bash
   git clone git@github.com:Indomet/Useful-Bash-Scripts.git
   cd Useful-Bash-Scripts/commit-msg-rewriter
   ```
Then put your repository that you want to edit the history inside this folder.

2. **Make the Script Executable:**
Navigate to your Git repository that you want to edit, and execute:

   ```bash
   chmod +x ../change_commit_message.sh
   ```

3. **Run the Script:**

   ```bash
   ../change_commit_message.sh <commit-id> "<new-commit-message>"
   ```

   Replace `<commit-id>` with the actual commit ID you want to modify, and `<new-commit-message>` with the desired commit message.

4. **Override the Branch (if needed):**

   If you have already pushed the commit with the wrong message, use the following command to override it:

   ```bash
   git push -f
   ```

   This command forcefully pushes the changes to the remote repository.

   **Note:** Be careful when using `git push -f` as it can impact collaboration.

The script will replace the original commit with the amended commit, and changes will be forcefully pushed to the remote repository using `git push -f`.

