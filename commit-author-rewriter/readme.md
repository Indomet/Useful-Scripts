# How to Correct Committer Information in Git

## 🛑🛑 WARNING 🛑🛑
* The author of this script bears no responsibility for any harm resulting from its use.
* Running this script implies your agreement to utilize it at your own risk, assuming full responsibility for any ensuing damage.
* The author disclaims any liability for the consequences of employing this script.
* The use of this script should not be associated with or encourage any form of criminal activity.

## Introduction
When you need to correct the committer information in your Git repository, follow these steps. However, be cautious, as modifying commit history using `git filter-branch` and forcefully pushing changes might have significant consequences. If something goes wrong you can follow the [Backup Step](#backup). 

## Disclaimer

Use this script with caution, especially in collaborative environments. Changing commit messages can affect the commit history and may cause conflicts if others have already pulled the original commits.

## Understand the Implications:

- **Loss of Commit History:** Modifying commit information generates new commits, replacing the old ones and rewriting the commit history.
- **Collaboration Challenges:** Rewriting history may lead to synchronization issues in collaborative environments.
- **Disruption of Integrations:** Modifying commit history can disrupt integrations with tools like CI pipelines, issue trackers, and code review systems.

## Important Notes Before Use

- Ensure that you are on a branch containing the commit you want to modify.
- The script will not work if the branch is set as protected. Make sure you have the necessary permissions.

## Running the Bash Script Directly Without Cloning

You can run the provided Bash script directly without the need to clone the repository. Simply copy and paste the script from [my website](https://indomet.github.io/posts/how-to-fix-wrong-committer/) into your terminal and follow those steps there. Otherwise follow the enxt steps here.

## 1. Clone the Repository:

```bash
git clone git@github.com:Indomet/Useful-Scripts.git
cd Useful-Scripts/commit-author-rewriter
```

Place the repository you wish to  the history of inside this folder.

## 2. Make the Script Executable:

Navigate to your Git repository that you want to edit, and execute:

```bash
chmod +x ../change_commit_author.sh
```

## 3. Run the Command:

```bash
../change_commit_author.sh
```

By following these steps, you can correct inaccurate committer information in your Git repository. Exercise caution and proceed only if you fully comprehend the potential consequences of modifying commit history, as this process rewrites the entire history and overrides the Git history in your GitHub branch.


## Backup
If something goes wrong when you're trying to push changes forcefully to GitHub, you can fix it by going to the backup folder. There, find the right version and then push it forcefully by typing:
```bash
git push -f
```

---
If you found this script helpful, please consider giving it a star 🌟, or if you want to contribute and expand this repository, feel free to create a fork and submit a pull request.

