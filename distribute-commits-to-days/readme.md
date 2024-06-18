# Change Commit Message Script

## 🛑🛑 WARNING 🛑🛑
* The author of this script bears no responsibility for any harm resulting from its use.
* Running this script implies your agreement to utilize it at your own risk, assuming full responsibility for any ensuing damage.
* The author disclaims any liability for the consequences of employing this script.
* The use of this script should not be associated with or encourage any form of criminal activity.

## Introduction

This Bash script allows you to distrubute commits to each day in a Git repository while preserving the original commit information. 

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
   cd Useful-Bash-Scripts/distribute-commits-to-days
   ```
Then put your repository that you want to edit the history inside this folder or alternatively copy the script and paste it inside git bash.

2. **Make the Script Executable:**
Navigate to your Git repository that you want to edit, and execute:

   ```bash
   chmod +x ../distribute.sh
   ```

3. **Run the Script:**

   ```bash
   ../distribute.sh 
   ```


4. **Override the Branch:**

   You can save the changes to ur git repository by force pushing

   ```bash
   git push -f
   ```

   This command forcefully pushes the changes to the remote repository.

   **Note:** Be careful when using `git push -f` as it can impact collaboration.

The script will replace the original commit dates so that each day, starting from the last commit date and moving backwards, will have exactly one commit, and changes will be forcefully pushed to the remote repository using `git push -f`.

---
If you found this script helpful, please consider giving it a star 🌟, or if you want to contribute and expand this repository, feel free to create a fork and submit a pull request.

